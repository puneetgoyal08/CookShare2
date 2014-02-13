//
//  RecipeViewController.m
//  CookShare2
//
//  Created by Puneet Goyal on 11/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation RecipeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.contentInset = UIEdgeInsetsMake(150, 0, -10, 0);
    self.tableView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
    self.tableView.tableFooterView.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"some random text";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *sectionView = [[UILabel alloc] init];
    sectionView.font = [UIFont fontWithName:Nil size:30];
    sectionView.backgroundColor = [UIColor whiteColor];
    switch (section) {
        case 0:
            sectionView.text = @"Introduction";
            break;
        case 1:
            sectionView.text = @"Ingredients";
            break;
        case 2:
            sectionView.text = @"Steps";
            break;
        case 3:
            sectionView.text = @"Reviews";
            break;
        default:
            sectionView.text = @"Title";
            break;
    }

    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

@end
