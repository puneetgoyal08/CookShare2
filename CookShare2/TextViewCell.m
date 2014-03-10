//
//  TextViewCell.m
//  CookShare2
//
//  Created by Puneet Goyal on 12/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "TextViewCell.h"

@interface TextViewCell()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *remove;

@end

@implementation TextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (id)addNewTextViewCellForIndexPath:(NSIndexPath *)indexPath withLabel:(NSString *)labelName
{
    TextViewCell *textViewCell = [[[NSBundle mainBundle] loadNibNamed:@"TextViewCell" owner:self options:nil] lastObject];
    textViewCell.textField.placeholder = labelName;
    textViewCell.textField.delegate = textViewCell;
    [textViewCell bringSubviewToFront:textViewCell.textField];
    [textViewCell bringSubviewToFront:textViewCell.remove];
    return textViewCell;
}

- (IBAction)removeButtonClicked:(id)sender{
    NSLog(@"remove button clicked");
}

#pragma mark - textfield delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField.text length]) {
        [textField resignFirstResponder];
        return YES;
    } else {
        return NO;
    }
}


@end
