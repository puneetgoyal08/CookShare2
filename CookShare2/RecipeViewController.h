//
//  RecipeViewController.h
//  CookShare2
//
//  Created by Puneet Goyal on 11/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dish.h"

@interface RecipeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Dish *dish;
@end
