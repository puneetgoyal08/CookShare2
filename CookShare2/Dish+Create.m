//
//  Dish+Create.m
//  CookShare2
//
//  Created by Puneet Goyal on 13/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "Dish+Create.h"

@implementation Dish (Create)

+(Dish *)dishWithTitle:(NSString *)title1 withDescription:(NSString *)desc inManagedObjectContext:(NSManagedObjectContext *)context
{
    Dish *dish = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Dish"];
    request.predicate = [NSPredicate predicateWithFormat:@"title = %@", title1];
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || [matches count]>1){
    
    } else if(matches.count==0){
        dish = [NSEntityDescription insertNewObjectForEntityForName:@"Dish" inManagedObjectContext:context];
        dish.title = title1;
        dish.desc = desc;
    } else {
        dish = [matches lastObject];
    }
    return dish;
}
@end
