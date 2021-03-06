//
//  LoginScreen.m
//  CookShare2
//
//  Created by Puneet Goyal on 21/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "LoginScreen.h"
#import "UIAlertView+error.h"
#import "API.h"
#include <CommonCrypto/CommonDigest.h>

#define kSalt @"adlfu3489tyh2jnkLIUGI&%EV(&0982cbgrykxjnk8855"

@implementation LoginScreen

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //focus on the username field / show keyboard
    [fldUsername becomeFirstResponder];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)btnLoginRegisterTapped:(UIButton*)sender {
	//form fields validation
	if (fldUsername.text.length < 4 || fldPassword.text.length < 4) {
		[UIAlertView error:@"Enter username and password over 4 chars each."];
		return;
	}
	//salt the password
	NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", fldPassword.text, kSalt];
	//prepare the hashed storage
	NSString* hashedPassword = nil;
	unsigned char hashedPasswordData[CC_SHA1_DIGEST_LENGTH];
	//hash the pass
	NSData *data = [saltedPassword dataUsingEncoding: NSUTF8StringEncoding];
	if (CC_SHA1([data bytes], [data length], hashedPasswordData)) {
		hashedPassword = [[NSString alloc] initWithBytes:hashedPasswordData length:sizeof(hashedPasswordData) encoding:NSASCIIStringEncoding];
	} else {
		[UIAlertView error:@"Password can't be sent"];
		return;
	}
	//check whether it's a login or register
	NSString* command = (sender.tag==1)?@"register":@"login";
	NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:command, @"command", fldUsername.text, @"username", hashedPassword, @"password", nil];
	//make the call to the web API
	[[API sharedInstance] commandWithParams:params onCompletion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"it worked");
        NSLog(@"Displaying the Datas Received %@",data);
        NSError *error;
        NSDictionary *json = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
        NSString *strResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Displaying the Datas Received In Readable Format %@",strResult);
		NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
		if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"IdUser"] intValue]>0) {
			[[API sharedInstance] setUser: res];
            [self performSelectorOnMainThread:@selector(presentMainViewController) withObject:nil waitUntilDone:NO];

			//show message to the user
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"Logged in" message:[NSString stringWithFormat:@"Welcome %@",[res objectForKey:@"username"]] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
            });
			
		} else {
			//error
			[UIAlertView error:[json objectForKey:@"error"]];
		}
	}];
}

- (void)presentMainViewController{
			[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
