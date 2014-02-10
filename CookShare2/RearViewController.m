
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

#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "CategoriesViewController.h"
#import "NewViewController.h"
#import "SettingsViewController.h"

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
			FrontViewController *frontViewController = [[FrontViewController alloc] init];
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
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}

@end