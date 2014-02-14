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

@implementation AddNewDish

+ (void)addDishWithTitle:(NSString *)title withDescription:(NSString *)desc inDocument:(UIManagedDocument *)document
{
    [CoreDataHelper openDocument:document usingBlock:^(UIManagedDocument *doc){
        Dish *dish = [Dish dishWithTitle:title withDescription:desc inManagedObjectContext:doc.managedObjectContext];
    }];
}
@end
