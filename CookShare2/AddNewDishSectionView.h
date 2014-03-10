//
//  AddNewDishSectionView.h
//  CookShare2
//
//  Created by Puneet Goyal on 09/03/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddNewSection <NSObject>

- (void)addNewSectionForSection:(int)section;

@end

@interface AddNewDishSectionView : UIView

@property (nonatomic, strong) id <AddNewSection> delegate;

+ (id)addNewDishSectionViewForSection:(int)section withLabel:(NSString *)labelName;

@end
