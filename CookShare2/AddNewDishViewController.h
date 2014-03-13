//
//  AddNewDishViewController.h
//  CookShare2
//
//  Created by Puneet Goyal on 12/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewDishSectionView.h"

@interface AddNewDishViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, AddNewSection, UITextFieldDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIManagedDocument *document;
@end
