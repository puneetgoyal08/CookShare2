//
//  AddNewDishSectionView.m
//  CookShare2
//
//  Created by Puneet Goyal on 09/03/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "AddNewDishSectionView.h"

@interface AddNewDishSectionView()

@property (nonatomic) int section;
@property (nonatomic, strong) IBOutlet UILabel* label;

@end
@implementation AddNewDishSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)addNewDishSectionViewForSection:(int)section withLabel:(NSString *)labelName
{
    AddNewDishSectionView *addNewDishSectionView = [[[NSBundle mainBundle] loadNibNamed:@"AddNewDishSectionView" owner:self options:nil] lastObject];
    addNewDishSectionView.label.text = labelName;
    if([addNewDishSectionView isKindOfClass:[AddNewDishSectionView class]]){
        addNewDishSectionView.section = section;
        return addNewDishSectionView;
    }
    else
        return nil;
}

- (IBAction)addClicked:(id)sender
{
    [self.delegate addNewSectionForSection:self.section];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
