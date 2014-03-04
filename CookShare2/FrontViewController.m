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

@interface FrontViewController()

@end

@implementation FrontViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!self.document)
    {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Photo Database"];
        self.document = [[UIManagedDocument alloc] initWithFileURL:url];
        [CoreDataHelper openDocument:self.document usingBlock:^(UIManagedDocument *document){
            self.document = document;
            [self setupFetchedResultsController];
        }];
    }
}

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Dish"];
    request.sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES], nil];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.document.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
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

#pragma mark - UICollectionView Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = [[self.fetchedResultsController fetchedObjects] count];
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recipeIcon" forIndexPath:indexPath];
    for(UIView *view in cell.subviews)
        [view removeFromSuperview];
    NSArray *photoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@".jpg" inDirectory:@"food_items"];
    NSString *path = [photoArray objectAtIndex:indexPath.row];
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
    iv.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    iv.contentMode = UIViewContentModeScaleAspectFit;
//    UIImage *pic = [UIImage imageWithContentsOfFile:path];
//    pic.
//    cell.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageWithContentsOfFile:path]];
    [cell addSubview:iv];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeViewController *recipeVC = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    recipeVC.dish = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [[self navigationController] pushViewController:recipeVC animated:YES];
    //IMPLEMENT this method
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}


@end