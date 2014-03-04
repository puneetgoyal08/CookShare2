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

@interface AddNewDishViewController ()
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextView *dishTitle;
@property (nonatomic, strong) IBOutlet UITextView *dishDescription;
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
    self.dishTitle = [self textViewWithTitle:@"Title of your dish"];
    self.dishTitle.delegate = self;
    self.dishDescription = [self textViewWithTitle:@"Description of your dish"];
    self.dishDescription.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextView *)textViewWithTitle:(NSString *)titl
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 40)];
    textView.textColor = [UIColor lightGrayColor];
    textView.text = titl;
    return textView;
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
    if([sender isKindOfClass:[UIButton class]])
    {
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
    else{
        NSArray *photoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@".jpg" inDirectory:@"food_items"];
        int numOfPhotos = [[[API sharedInstance] numberOfPhotos] integerValue];
        NSString *path = [photoArray objectAtIndex:numOfPhotos];
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        [AddNewDish addDishWithTitle:self.dishTitle.text withDescription:self.dishDescription.text withImage:iv inDocument:self.document];
        [[API sharedInstance] setNumberOfPhotos:[NSNumber numberWithInteger:numOfPhotos + 1]];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    for(UIView *view in cell.contentView.subviews)
        [view removeFromSuperview];

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
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - TextField Delegate Methods

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView.textColor == [UIColor lightGrayColor]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}


@end
