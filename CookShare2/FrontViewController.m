/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
*/

#import "FrontViewController.h"
#import "SWRevealViewController.h"
#import "RecipeCollectionViewCell.h"
#import "RecipeViewController.h"
#import "AddNewDishViewController.h"

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

- (IBAction)addNewDish:(id)sender
{
    [[self navigationController]pushViewController:[[AddNewDishViewController alloc] init] animated:YES];
}

#pragma mark - UICollectionView Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *photoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@".jpg" inDirectory:@"food_items"];
    return  photoArray.count;
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
    [[self navigationController] pushViewController:recipeVC animated:YES];
    //IMPLEMENT this method
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog( @"%@: FRONT", NSStringFromSelector(_cmd));
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog( @"%@: FRONT", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSLog( @"%@: FRONT", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    NSLog( @"%@: FRONT", NSStringFromSelector(_cmd));
//}

@end