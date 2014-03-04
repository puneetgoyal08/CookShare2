//
//  UIAlertView+error.m
//  CookShare2
//
//  Created by Puneet Goyal on 21/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "UIAlertView+error.h"

@implementation UIAlertView(error)
+(void)error:(NSString*)msg
{
    [[[UIAlertView alloc] initWithTitle:@"Error" 
                                message:msg 
                               delegate:nil 
                      cancelButtonTitle:@"Close" 
                      otherButtonTitles: nil] show];
}
@end
