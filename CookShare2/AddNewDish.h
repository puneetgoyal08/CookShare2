//
//  AddNewDish.h
//  CookShare2
//
//  Created by Puneet Goyal on 13/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddNewDish : NSObject

+ (void)addDishWithTitle:(NSString *)title withDescription:(NSString *)desc withImage:(UIImageView *)photo inDocument:(UIManagedDocument *)document;
+ (void)addDishWithInfo:(NSDictionary *)info;

@end
