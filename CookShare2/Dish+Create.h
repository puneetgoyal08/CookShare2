//
//  Dish+Create.h
//  CookShare2
//
//  Created by Puneet Goyal on 13/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "Dish.h"

@interface Dish (Create)

+ (Dish *)dishWithTitle: (NSString *)title withDescription:(NSString *)desc inManagedObjectContext:(NSManagedObjectContext *)context;
@end
