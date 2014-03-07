//
//  FrontViewController.m
//  CookShare2
//
//  Created by Puneet Goyal on 21/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "FrontViewController.h"
#import "SWRevealViewController.h"
#import "RecipeCollectionViewCell.h"
#import "RecipeViewController.h"
#import "AddNewDishViewController.h"
#import "CoreDataHelper.h"
#import "API.h"
#import "LoginScreen.h"
#import "PhotoView.h"
#import "CacheFileManager.h"

@interface FrontViewController() <PhotoViewDelegate>

@property (nonatomic, strong) NSArray *stream;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation FrontViewController

@synthesize stream = _stream;
@synthesize queue = _queue;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"Home", nil);
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
        style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewDish:)];
    
    [self.collectionView registerClass:[RecipeCollectionViewCell class] forCellWithReuseIdentifier:@"recipeIcon"];
    [self refreshStream];
}

- (IBAction)addNewDish:(id)sender
{
    if(![[API sharedInstance] isAuthorized])
    {
        LoginScreen *loginScreen = [[LoginScreen alloc] initWithNibName:@"LoginScreen" bundle:nil];
        [self presentViewController:loginScreen animated:NO completion:nil];
    }
    if([[API sharedInstance] isAuthorized])
    {
        AddNewDishViewController *addNewDishVC = [[AddNewDishViewController alloc] init];
        addNewDishVC.document = self.document;
        [[self navigationController] pushViewController:addNewDishVC animated:YES];
    }
}

-(void)refreshStream {
    UIActivityIndicatorView *refreshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    refreshIndicator.frame = CGRectMake(150, 150, 50, 50);
    [refreshIndicator startAnimating];
    [self.view addSubview:refreshIndicator];
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command", nil] onCompletion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error = nil;
        NSDictionary *json = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
        [self setStream:[json objectForKey:@"result"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [refreshIndicator removeFromSuperview];
            [self.collectionView reloadData];
        });
    }];
}

#pragma mark - UICollectionView Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = self.stream.count;
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recipeIcon" forIndexPath:indexPath];
    for(UIView *view in cell.contentView.subviews)
        [view removeFromSuperview];
//    UIActivityIndicatorView *refreshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    [refreshIndicator startAnimating];
//    [cell.contentView addSubview:refreshIndicator];
    if(!self.queue){
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 1;
    }
    
    PhotoView *pView = [[PhotoView alloc] initWithIndex:indexPath.row andData:[self.stream objectAtIndex:indexPath.row]];
    [cell.contentView addSubview:pView];

//    dispatch_queue_t downloadQueue = dispatch_queue_create("photo download", NULL);
//    dispatch_async(downloadQueue, ^{
//        PhotoView *pView = [[PhotoView alloc] initWithIndex:indexPath.row andData:[self.stream objectAtIndex:indexPath.row]];
//        dispatch_async(dispatch_get_main_queue(), ^{
////            for(UIView *view in cell.contentView.subviews)
////                [view removeFromSuperview];
//            [cell.contentView addSubview:pView];
//            [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//        });
//    });

//    [self.queue addOperationWithBlock:^{
//        API* api = [API sharedInstance];
//		int IdPhoto = [[[self.stream objectAtIndex:indexPath.row] objectForKey:@"IdPhoto"] intValue];
//		NSURL* imageURL = [api urlForImageWithId:[NSNumber numberWithInt: IdPhoto] isThumb:YES];
//        NSData* imageData = [CacheFileManager getFileAtUrl:imageURL];
//        UIImageView* thumbView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
//        thumbView.contentMode = UIViewContentModeScaleToFill;
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            for(UIView *view in cell.subviews)
//                [view removeFromSuperview];
//            [cell.contentView addSubview:thumbView];
//        }];

//        PhotoView *pView = [[PhotoView alloc] initWithIndex:indexPath.row andData:[self.stream objectAtIndex:indexPath.row]];
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            for(UIView *view in cell.subviews)
//                [view removeFromSuperview];
//            [cell addSubview:pView];
//        }];
//    }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeViewController *recipeVC = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    [[self navigationController] pushViewController:recipeVC animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}

#pragma mark - PhotoViewDelegate

-(void)didSelectPhoto:(id)sender
{
    PhotoView *view = (PhotoView *)sender;
    NSLog(@"photo got selected");
}


@end