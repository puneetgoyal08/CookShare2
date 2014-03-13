//
//  TextViewCell.h
//  CookShare2
//
//  Created by Puneet Goyal on 12/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewCell : UIView <UITextFieldDelegate>

@property (nonatomic, strong) NSString *text;
+ (id)addNewTextViewCellForIndexPath:(NSIndexPath *)indexPath withLabel:(NSString *)labelName;

@end
