
//
//  RearViewController.m
//  CookShare2
//
//  Created by Puneet Goyal on 21/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//


#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "CategoriesViewController.h"
#import "NewViewController.h"
#import "SettingsViewController.h"
#import "LoginScreen.h"

@interface RearViewController()

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;


#pragma mark - View lifecycle


- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"Menu", nil);
}


#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
	
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	if (row == 0)
	{
        UILabel *cellName = [[UILabel alloc] initWithFrame:CGRectMake(50, cell.frame.origin.y, cell.frame.size.width-50, cell.frame.size.height)];
        cellName.text = @"Home";
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 30, 30)];
        iv.image = [UIImage imageNamed:@"home.png"];
        [cell.contentView addSubview:iv];
        [cell.contentView addSubview:cellName];
	}
	else if (row == 1)
	{
        UILabel *cellName = [[UILabel alloc] initWithFrame:CGRectMake(50, cell.frame.origin.y, cell.frame.size.width-50, cell.frame.size.height)];
        cellName.text = @"Categories";
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 30, 30)];
        iv.image = [UIImage imageNamed:@"flower.png"];
        [cell.contentView addSubview:iv];
        [cell.contentView addSubview:cellName];
	}
	else if (row == 2)
	{
        UILabel *cellName = [[UILabel alloc] initWithFrame:CGRectMake(50, cell.frame.origin.y, cell.frame.size.width-50, cell.frame.size.height)];
        cellName.text = @"Whats New?";
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 30, 30)];
        iv.image = [UIImage imageNamed:@"new.png"];
        [cell.contentView addSubview:iv];
        [cell.contentView addSubview:cellName];
	}
	else if (row == 3)
	{
        UILabel *cellName = [[UILabel alloc] initWithFrame:CGRectMake(50, cell.frame.origin.y, cell.frame.size.width-50, cell.frame.size.height)];
        cellName.text = @"Settings";
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 30, 30)];
        iv.image = [UIImage imageNamed:@"spanner.png"];
        [cell.contentView addSubview:iv];
        [cell.contentView addSubview:cellName];
	}
    else if (row==4)
    {
        UILabel *cellName = [[UILabel alloc] initWithFrame:CGRectMake(50, cell.frame.origin.y, cell.frame.size.width-50, cell.frame.size.height)];
        cellName.text = @"Login";
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 30, 30)];
        iv.image = [UIImage imageNamed:@"man.png"];;
        [cell.contentView addSubview:iv];
        [cell.contentView addSubview:cellName];
    }
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // We know the frontViewController is a NavigationController
    UINavigationController *frontNavigationController = (id)revealController.frontViewController;  // <-- we know it is a NavigationController
    NSInteger row = indexPath.row;

	// Here you'd implement some of your own logic... I simply take for granted that the first row (=0) corresponds to the "FrontViewController".
	if (row == 0)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.        
        if ( ![frontNavigationController.topViewController isKindOfClass:[FrontViewController class]] )
        {
            FrontViewController *frontViewController = [[FrontViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
    
	// ... and the second row (=1) corresponds to the "MapViewController".
	else if (row == 1)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[CategoriesViewController class]] )
        {
            CategoriesViewController *catViewController = [[CategoriesViewController alloc] initWithNibName:@"CategoriesViewController" bundle:nil];
            [revealController setFrontViewController:[[UINavigationController alloc] initWithRootViewController:catViewController] animated:YES];
        }
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
	else if (row == 2)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[NewViewController class]] )
        {
            NewViewController *newVC = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
            [revealController setFrontViewController:[[UINavigationController alloc] initWithRootViewController:newVC] animated:YES];
        }
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
	else if (row == 3)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[SettingsViewController class]] )
        {
            SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
            [revealController setFrontViewController:[[UINavigationController alloc] initWithRootViewController:settingsVC] animated:YES];
        }
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
    else if (row == 4)
    {
        if( ![frontNavigationController.topViewController isKindOfClass:[LoginScreen class]])
        {
            LoginScreen *loginScreen = [[LoginScreen alloc] initWithNibName:@"LoginScreen" bundle:nil];
            [revealController setFrontViewController:[[UINavigationController alloc] initWithRootViewController:loginScreen] animated:YES];
        }
        else
        {
            [revealController revealToggle:self];
        }
    }
}

@end