//
//  AddNewDishViewController.m
//  CookShare2
//
//  Created by Puneet Goyal on 12/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "AddNewDishViewController.h"
#import "AddNewDish.h"
#import "API.h"
#import "AddNewDishSectionView.h"
#import "TextViewCell.h"

@interface AddNewDishViewController ()
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextField *dishTitle;
@property (nonatomic, strong) IBOutlet UITextField *dishDescription;
@property (nonatomic) BOOL updateRows;
@property (nonatomic) NSMutableDictionary* numberOfRowsInSection;
@end

@implementation AddNewDishViewController
@synthesize tableView = _tableView;
@synthesize document = _document;
@synthesize dishDescription;
@synthesize dishTitle;

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
    self.dishTitle = [self textFieldWithTitle:@"Title of your dish"];
    self.dishTitle.delegate = self;
    self.dishDescription = [self textFieldWithTitle:@"Description of your dish"];
    self.dishDescription.delegate = self;
    self.numberOfRowsInSection = [[NSMutableDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:4],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1], nil] forKeys:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3], nil]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextField *)textFieldWithTitle:(NSString *)titl
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 40)];
    textField.placeholder = titl;
    textField.delegate = self;
    return textField;
}

- (UIView *)imageViewWithImage:(UIImage *)image
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    iv.frame = CGRectMake(10, 7, self.view.frame.size.width, 30);
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];

    [iv addGestureRecognizer:singleTap];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    return iv;
}

- (UIButton *)buttonWithTitle:(NSString *)title1
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(buttonTapped:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:title1 forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 7, 160.0, 30);
    return button;
}

- (IBAction)singleTapping:(id)sender
{
    if([sender isKindOfClass:[UIImageView class]])
    {
        
    }
    NSLog(@"Upload button tapped");
}

- (IBAction)buttonTapped:(UIButton *)sender
{
    if([sender isKindOfClass:[UIButton class]]) {
        if([sender.titleLabel.text isEqualToString:@"Upload"])
            NSLog(@"upload tapped");
        else if([sender.titleLabel.text isEqualToString:@"Submit"])
            [self submitInfo];
    }
}

- (void)submitInfo
{
    if([self.dishTitle.text isEqualToString:@""]|| [self.dishDescription.text isEqualToString:@""])
        NSLog(@"both fields are empty");
    else {
        NSArray *intro = [NSArray arrayWithObjects:self.dishTitle.text, self.dishDescription.text, nil];
        NSMutableArray *ingridients = [[NSMutableArray alloc] init];
        for(int i=0;i<[[self.numberOfRowsInSection objectForKey:[NSNumber numberWithInt:1]] integerValue];i++){
            UITextField *textField = [[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]] subviews] lastObject];
            [ingridients addObject:textField.text];
        }
        
        NSMutableArray *steps = [[NSMutableArray alloc] init];
        for(int i=0;i<[[self.numberOfRowsInSection objectForKey:[NSNumber numberWithInt:1]] integerValue];i++){
            UITextField *textField = [[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2]] subviews] lastObject];
            [steps addObject:textField.text];
        }
 
        NSArray *photoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@".jpg" inDirectory:@"food_items"];
        int numOfPhotos = [[[API sharedInstance] numberOfPhotos] integerValue];
        NSString *path = [photoArray objectAtIndex:numOfPhotos];
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        NSDictionary *info = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:intro, ingridients, steps,iv, nil] forKeys:[NSArray arrayWithObjects:@"intro", @"ingridiends", @"steps", @"imageView", nil]];

        [AddNewDish addDishWithTitle:self.dishTitle.text withDescription:self.dishDescription.text withImage:iv inDocument:self.document];
        [[API sharedInstance] setNumberOfPhotos:[NSNumber numberWithInteger:numOfPhotos + 1]];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numOfRows = [[self.numberOfRowsInSection objectForKey:[NSNumber numberWithInt:section]] integerValue];
    return numOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if(indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [cell.contentView addSubview:self.dishTitle];
                break;
            case 1:
                [cell.contentView addSubview:self.dishDescription];
                break;
            case 2:
                [cell.contentView addSubview:[self buttonWithTitle:@"Upload"]];
                break;
            case 3:
                [cell.contentView addSubview:[self buttonWithTitle:@"Submit"]];
                break;
            default:
                break;
        }
    } else if(indexPath.section == 1) {
        TextViewCell *textView = [TextViewCell addNewTextViewCellForIndexPath:indexPath withLabel:[NSString stringWithFormat:@"Item %d", indexPath.row+1]];
        [cell addSubview:textView];
    } else if(indexPath.section == 2) {
        TextViewCell *textView = [TextViewCell addNewTextViewCellForIndexPath:indexPath withLabel:[NSString stringWithFormat:@"Step %d", indexPath.row+1]];
        [cell addSubview:textView];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return @"Introduction";
    else if(section == 1)
        return @"Ingridients";
    else if(section == 2)
        return @"Steps";
    else
        return @"Random";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1) {
        AddNewDishSectionView *view = [AddNewDishSectionView addNewDishSectionViewForSection:section withLabel:@"Ingridients"];
        view.delegate = self;
        return view;
    }
    else if(section == 2) {
        AddNewDishSectionView *view = [AddNewDishSectionView addNewDishSectionViewForSection:section withLabel:@"Steps"];
        view.delegate = self;
        return view;
    }
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - TextField Delegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField.text length]) {
        [textField resignFirstResponder];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - AddNewSection delegate methods

- (void)addNewSectionForSection:(int)section
{
    self.updateRows = YES;
    int prevNum = [[self.numberOfRowsInSection objectForKey:[NSNumber numberWithInt:section]] integerValue];
    [self.numberOfRowsInSection setObject:[NSNumber numberWithInt:prevNum+1] forKey:[NSNumber numberWithInt:section]];
    [self.tableView insertRowsAtIndexPaths:[[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:section] inSection:section], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
