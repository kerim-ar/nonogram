//
//  NCollectionCellController.m
//  Nonagram
//
//  Created by Student on 27.03.14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "NCollectionCellController.h"
#import "NCollectionViewCell.h"
#import "AppDelegate.h"
#import "NNonagramField.h"
#import "NViewControllerNonagram.h"
#import "NNonagramManager.h"
#import <CoreData/NSFetchRequest.h>

#import "DrEditUtilities.h"


// Constants used for OAuth 2.0 authorization.
static NSString *const kKeychainItemName = @"Nonogram";
static NSString *const kClientId = @"";
static NSString *const kClientSecret = @"";


@interface NCollectionCellController ()
@property (nonatomic, strong) NSArray *cellsData;
@property (nonatomic, strong) NSArray *listNonagram;
@property (nonatomic, assign) int fieldWidth;
@property (nonatomic, assign) int fieldHeight;
@property (nonatomic, strong) NNonagramManager *nonagramManager;
@property (nonatomic, strong) NNonagramField *field;

@property (weak, readonly) GTLServiceDrive *driveService;
@property (retain) NSMutableArray *driveFiles;
@property BOOL isAuthorized;


- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error;
- (void)isAuthorizedWithAuthentication:(GTMOAuth2Authentication *)auth;
- (void)loadDriveFiles;
@end

@implementation NCollectionCellController
@synthesize driveFiles = _driveFiles;
@synthesize isAuthorized = _isAuthorized;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation-bar-top"] forBarMetrics:UIBarMetricsDefault];
    self.nonagramManager = [NNonagramManager new];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.nonagramManager getNonagrams].count;
}

-(void) viewWillAppear:(BOOL)animated
{
   self.navigationController.navigationBar.hidden = NO; 
}

-(void) viewDidAppear:(BOOL)animated
{
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellCustom"
                                                                           forIndexPath:indexPath];
    
    NNonagramField *fieldNonagram = [self.nonagramManager getNonagrams][indexPath.row];
    
    cell.contentView.layer.borderColor = [[UIColor colorWithRed:135/256.0 green:29/256.0 blue:0/256.0 alpha:1.0] CGColor];
    cell.contentView.layer.borderWidth = 2;
    
    cell.labelCellName.text = fieldNonagram.title;
    cell.labelCellSize.text = [NSString stringWithFormat:@"%@x%@", fieldNonagram.width, fieldNonagram.height];
    
    cell.progress.progress = [fieldNonagram.progress floatValue];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectNonagram"]) {
        
        NViewControllerNonagram *inst = segue.destinationViewController;
        inst.field = self.field;
        self.field = nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.field = [self.nonagramManager getNonagrams][indexPath.row];
    [self performSegueWithIdentifier:@"SelectNonagram" sender:self];
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (GTLServiceDrive *)driveService {
    static GTLServiceDrive *service = nil;
    
    if (!service) {
        service = [[GTLServiceDrive alloc] init];
        
        // Have the service object set tickets to fetch consecutive pages
        // of the feed so we do not need to manually fetch them.
        service.shouldFetchNextPages = YES;
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically.
        service.retryEnabled = YES;
    }
    return service;
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
    if (error == nil) {
        [self isAuthorizedWithAuthentication:auth];
    }
}

- (IBAction)loadButtonTapped:(UIButton *)sender
{
    NSLog(@"load button tapped");
    
    [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
    [[self driveService] setAuthorizer:nil];
    [self.driveFiles removeAllObjects];
    
    SEL finishedSelector = @selector(viewController:finishedWithAuth:error:);
    GTMOAuth2ViewControllerTouch *authViewController =
    [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeDrive
                                               clientID:kClientId
                                           clientSecret:kClientSecret
                                       keychainItemName:kKeychainItemName
                                               delegate:self
                                       finishedSelector:finishedSelector];
    [self presentModalViewController:authViewController
                            animated:YES];
}

- (void)stopAuthorizationForRequest:(NSURLRequest *)request
{
    
}

- (void)isAuthorizedWithAuthentication:(GTMOAuth2Authentication *)auth {
    // авторизовались
    [[self driveService] setAuthorizer:auth];
    [self loadDriveFiles];
}

- (void)loadDriveFiles {
    GTLQueryDrive *query = [GTLQueryDrive queryForFilesList];
    query.q = @"mimeType = 'text/plain'"; // text/plain
    
    
    UIAlertView *alert = [DrEditUtilities showLoadingMessageWithTitle:@"Loading files"
                                                             delegate:self];
    
     
    [self.driveService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                              GTLDriveFileList *files,
                                                              NSError *error) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        if (error == nil) {
            if (self.driveFiles == nil) {
                self.driveFiles = [[NSMutableArray alloc] init];
            }
            [self.driveFiles removeAllObjects];
            [self.driveFiles addObjectsFromArray:files.items];
            [self selectNeedFiles];
            [self saveNonogramsInDB];
            NSLog(@"файлы загружены!");
        } else {
            NSLog(@"An error occurred: %@", error);
            [DrEditUtilities showErrorMessageWithTitle:@"Unable to load files"
                                               message:[error description]
                                              delegate:self];
            
        }
    }];
}

- (NSInteger)didUpdateFileWithIndex:(NSInteger)index
                          driveFile:(GTLDriveFile *)driveFile {
    if (index == -1) {
        if (driveFile != nil) {
            // New file inserted.
            [self.driveFiles insertObject:driveFile atIndex:0];
            index = 0;
        }
    } else {
        if (driveFile != nil) {
            // File has been updated.
            [self.driveFiles replaceObjectAtIndex:index withObject:driveFile];
        } else {
            // File has been deleted.
            [self.driveFiles removeObjectAtIndex:index];
            index = -1;
        }
    }
    return index;  
}

-(void)selectNeedFiles{
    NSMutableArray *discardedItems = [NSMutableArray array];
    
    for (GTLDriveFile *file in self.driveFiles) {
        if ([file.title rangeOfString:@".nonogram.txt"].location == NSNotFound) {
            [discardedItems addObject:file];
        }
    }
    [self.driveFiles removeObjectsInArray:discardedItems];
}

-(void)saveNonogramsInDB {
    NNonagramManager *nonogramManager = [[NNonagramManager alloc] init];
    for (GTLDriveFile *file in self.driveFiles) {
        GTMHTTPFetcher *fetcher =
        [self.driveService.fetcherService fetcherWithURLString:file.downloadUrl];
        [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
            if (error == nil) {
                NSString* fileContent = [[NSString alloc] initWithData:data
                                                              encoding:NSUTF8StringEncoding];
                //save nonogram in DB
                NSArray *params = [fileContent componentsSeparatedByString:@"#"];
                [nonogramManager saveNonogramWith:[params objectAtIndex:0] and:[params objectAtIndex:1] and:[params objectAtIndex:2] and:[params objectAtIndex:3]];
                NSLog(@"%@", params);
            } else {
                NSLog(@"An error occurred: %@", error);
                
            }
        }];
    }
}


@end
