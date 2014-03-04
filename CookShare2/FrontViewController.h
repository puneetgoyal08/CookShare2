//
//  FrontViewController.h
//  CookShare2
//
//  Created by Puneet Goyal on 21/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFMasterViewController.h"

@interface FrontViewController : AFMasterViewController<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIManagedDocument *document;

@end