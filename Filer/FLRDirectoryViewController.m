//
//  FLRDirectoryViewController.m
//  Filer
//
//  Created by Jonathan on 04/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRDirectoryViewController.h"
#import "FLRDirectory.h"
#import <CocoaHTTPServer/HTTPServer.h>
#import <DDLog.h>
#import <DDTTYLogger.h>
#import "FLRHTTPConnection.h"
#import "FLRWebServer.h"
#import <ZipArchive/ZipArchive.h>
#import "UIBarButtonItem+autorelease.h"
#import "UIAlertController+FLRExtensions.h"
#import "UIAlertAction+FLRExtensions.h"
#import "UIViewController+FLRExtensions.h"
#import "FLRApplication.h"
#import "FLRFileViewController.h"
#import "FLRFile.h"
#import "FLRZippedDirectory.h"
#import "FLRFileListViewController.h"
#import "UITableView+FLRExtensions.h"
#import "FLRNavigationController.h"
#import "FLRSettingsManager.h"
#import "FLRViewController.h"

@interface FLRDirectoryViewController () <UIToolbarDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (readonly) UITableView *tableView;
@end

@interface ZipArchive (zipext)
-(BOOL)addDirToZip:(NSString *)dirpath;
-(BOOL)addFileToZip:(NSString *)file;
@end
@implementation ZipArchive (zipext)

-(BOOL)addDirToZip:(NSString *)dirpath {
    NSString *dirname = [dirpath lastPathComponent];
    NSDirectoryEnumerator *dir = [[NSFileManager defaultManager] enumeratorAtPath:dirpath];
    NSString *file;
    BOOL success = YES;
    while (file = [dir nextObject]) {
        success = [self addFileToZip:[dirpath stringByAppendingPathComponent:file] newname:[dirname stringByAppendingPathComponent:file]] && success;
    }
    return success;
}

-(BOOL)addFileToZip:(NSString *)file {
    return [self addFileToZip:file newname:[file lastPathComponent]];
}

@end

@implementation FLRDirectoryViewController

-(FLRDirectory *)currentDirectory {
    if (!_currentDirectory) {
        self.currentDirectory = [[FLRDirectory alloc] initWithPath:@"/"];
    }
    return _currentDirectory;
}

-(UITableView *)tableView {
    return [[self childViewControllers][0] tableView];
}
-(FLRFileListViewController *)listViewController {
    return [self childViewControllers][0];
}

-(void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
    [[self tableView] setDelegate:self];
    UIRefreshControl * refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self.currentDirectory action:@selector(directoryChanged) forControlEvents:UIControlEventValueChanged];
    [[self tableView] addSubview:refreshControl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.currentDirectory name];
    [self setTopToolbarHeight:25];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(directoryChanged:) name:FLRDirectoryContentsChanged object:self.currentDirectory];
    self.toolbarItems = self.standardToolbarItems;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.topToolbarItems = @[ [UIBarButtonItem flexibleSpace],
                              [UIBarButtonItem barButtonItemWithTitle:@"Select All" style:UIBarButtonItemStylePlain target:self action:@selector(selectAll)],
                              [UIBarButtonItem flexibleSpace],
                              [UIBarButtonItem barButtonItemWithTitle:@"Invert Selection" style:UIBarButtonItemStylePlain target:self action:@selector(invertSelection)],
                              [UIBarButtonItem flexibleSpace]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[FLRApplication sharedApplication] setCurrentPath:self.currentDirectory.path];
    [[FLRWebServer sharedInstance] setCurrentPath:self.currentDirectory.path];
}



-(void)selectAll {
    [self.tableView selectAllRowsInSection:0];
}
-(void)invertSelection {
    [self.tableView invertSelectionInSection:0];
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self updateEditingButtons:[self tableView]];
    [self setTopToolbarHidden:!editing];
    UIEdgeInsets insets = [[self tableView] contentInset];
    insets.top += self.topToolbarHeight * (editing ? 1 : -1);
    [UIView animateWithDuration:0.2 animations:^{
        [[self tableView] setContentInset:insets];
    }];
    CGPoint coffset = self.tableView.contentOffset;
    coffset.y -= self.topToolbarHeight * (editing ? 1 : 0);
    [[self tableView] setContentOffset:coffset animated:YES];
    [self.tableView setEditing:editing animated:animated];
    [self setToolbarItems:editing ? self.editingToolbarItems : self.standardToolbarItems animated:YES];
}

-(void)directoryChanged:(NSNotification *)note {
    [[self listViewController] setFiles:[self.currentDirectory contents]];
}

-(FLRFileSystemItem *)itemForIndexPath:(NSIndexPath *)indexPath {
    return [self.currentDirectory contents][indexPath.row];
}


#pragma mark - Navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return YES;
}
// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"embedFileList"]) {
        FLRFileListViewController *dest = (FLRFileListViewController *)segue.destinationViewController;
        [dest setFiles:[self.currentDirectory contents]];
    }
}

- (IBAction)add:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"New Folder" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self presentViewController:[UIAlertController textfieldAlertControllerWithTitle:@"Enter folder name" buttonText:@"Create" handler:^(NSString *folderName) {
            NSError *error = nil;
            if (![self.currentDirectory createNewDirectoryNamed:folderName error:&error]) {
                [self presentViewController:[UIAlertController alertControllerWithError:error]];
            }
        }]];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"New File" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [alertController addAction:[UIAlertAction cancelAction]];
    [alertController.popoverPresentationController setBarButtonItem:sender];
    [self presentViewController:alertController];
}
- (IBAction)compress:(UIBarButtonItem *)sender {
    [self presentViewController:[UIAlertController textfieldAlertControllerWithTitle:@"Enter archive name" buttonText:@"Archive" handler:^(NSString *folderName) {
        ZipArchive *archive = [[ZipArchive alloc] initWithFileManager:[NSFileManager defaultManager]];
        [archive CreateZipFile2:[[self.currentDirectory.path stringByAppendingPathComponent:folderName] stringByAppendingPathExtension:@"zip"]];
        NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
        for (NSIndexPath *indexPath in indexPaths) {
            FLRFileSystemItem *item = [self itemForIndexPath:indexPath];
            if ([item isDirectory]) {
                [archive addDirToZip:[item path]];
            } else {
                [archive addFileToZip:[item path]];
            }
        }
        BOOL close = [archive CloseZipFile2];
        [self.currentDirectory directoryChanged];
    }]];
}

- (IBAction)share:(UIBarButtonItem *)sender {
    NSArray *items;
    if (self.isEditing) {
        NSMutableArray *fileURLs = [NSMutableArray array];
        for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
            [fileURLs addObject:[NSURL fileURLWithPath:[[self itemForIndexPath:indexPath] path]]];
        }
        items = fileURLs;
    } else {
        items = @[[NSURL fileURLWithPath:self.currentDirectory.path]];
    }
    UIActivityViewController *actVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    [actVC.popoverPresentationController setBarButtonItem:sender];
    [self presentViewController:actVC];
}
-(void)updateEditingButtons:(UITableView *)tableView {
    NSUInteger selectedCount = [[tableView indexPathsForSelectedRows] count];
    [self.compressButton setEnabled:selectedCount > 0];
    [self.renameButton setEnabled:selectedCount == 1];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self updateEditingButtons:tableView];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self updateEditingButtons:tableView];
}

- (IBAction)rename:(UIBarButtonItem *)sender {
    FLRFileSystemItem * item = [self itemForIndexPath:[self.tableView indexPathForSelectedRow]];
    [self presentViewController:[UIAlertController textfieldAlertControllerWithTitle:@"Enter new name" buttonText:@"Rename"
                                 textFieldConfig:^(UITextField *textField) {
                                     [textField setText:[item.path lastPathComponent]];
                                     [textField performSelector:@selector(selectAll:) withObject:nil afterDelay:0];
                                 }
                                 handler:^(NSString *folderName) {
        void (^doRename)(UIAlertAction *) = ^(UIAlertAction *action){
            [item rename:folderName];
            [self.currentDirectory directoryChanged];
        };
        NSString *oldExtension = [item.path pathExtension];
        NSString *newExtension = [folderName pathExtension];
        if ([oldExtension length] != 0 && ![oldExtension isEqualToString:newExtension]) {
            NSString *title = @"Change extension?";
            NSString *message = [NSString stringWithFormat:@"The new extension (%@) differs from the old one (%@)", newExtension, oldExtension];
            NSString *changeActionTitle = [NSString stringWithFormat:@"Use %@", newExtension];
            if ([[folderName pathExtension] length] == 0) {
                title = @"Remove extension?";
                message = [NSString stringWithFormat:@"There is no extension in the new name, the old one was %@", oldExtension];
                changeActionTitle = [NSString stringWithFormat:@"Remove %@", oldExtension];
            }
            UIAlertController *extController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [extController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Keep %@", oldExtension] style:UIAlertActionStyleCancel handler:nil]];
            [extController addAction:[UIAlertAction actionWithTitle:changeActionTitle style:UIAlertActionStyleDefault handler:doRename]];
            [self presentViewController:extController];
        } else {
            doRename(nil);
        }
    }]];
}

- (IBAction)goHome:(UIBarButtonItem *)sender {
    [self.navigationController goToPath:[[FLRSettingsManager sharedInstance] homePath]];
}
@end
