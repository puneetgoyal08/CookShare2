//
//  AddNewDish.m
//  CookShare2
//
//  Created by Puneet Goyal on 13/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "AddNewDish.h"
#import "CoreDataHelper.h"
#import "Dish+Create.h"
#import "API.h"

@implementation AddNewDish

+ (void)addDishWithTitle:(NSString *)title withDescription:(NSString *)desc withImage:(UIImageView *)photo inDocument:(UIManagedDocument *)document
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"upload",photo.image,title, nil] forKeys:[[NSArray alloc] initWithObjects:@"command", @"file",@"title", nil]];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //completion
        NSLog(@"Displaying the Datas Received %@",data);
        NSError *error;
        NSDictionary *json = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
        NSString *strResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Displaying the Datas Received In Readable Format %@",strResult);

        if (![json objectForKey:@"error"]) {
            //success
            [[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your photo is uploaded" delegate:nil cancelButtonTitle:@"Yay!" otherButtonTitles: nil] show];
        }
    }];
}

@end
