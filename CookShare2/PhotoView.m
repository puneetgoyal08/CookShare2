//
//  PhotoView.m
//  iReporter
//
//  Created by Fahim Farook on 9/6/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "PhotoView.h"
#import "API.h"
#import "CacheFileManager.h"

@implementation PhotoView

@synthesize delegate;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithIndex:(int)i andData:(NSDictionary*)data {
    self = [super init];
    if (self !=nil) {
        UIActivityIndicatorView *refreshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        refreshIndicator.frame = CGRectMake(kThumbSide/2, kThumbSide/2, 10, 10);
        [refreshIndicator startAnimating];
        
        //initialize
        for(UIView* subview in self.subviews)
            [subview removeFromSuperview];
        [self addSubview:refreshIndicator];
        self.tag = [[data objectForKey:@"IdPhoto"] intValue];
        self.frame = CGRectMake(0, 0, kThumbSide, kThumbSide);
        self.backgroundColor = [UIColor grayColor];
        //add the photo caption
        UILabel* caption = [[UILabel alloc] initWithFrame:CGRectMake(0, kThumbSide-16, kThumbSide, 16)];
        caption.backgroundColor = [UIColor blackColor];
        caption.textColor = [UIColor whiteColor];
        caption.font = [UIFont systemFontOfSize:12];
        caption.text = [NSString stringWithFormat:@"@%@",[data objectForKey:@"username"]];
        [self addSubview: caption];
		API* api = [API sharedInstance];
		int IdPhoto = [[data objectForKey:@"IdPhoto"] intValue];
		NSURL* imageURL = [api urlForImageWithId:[NSNumber numberWithInt: IdPhoto] isThumb:YES];
        
        dispatch_queue_t queue = dispatch_queue_create("download queue", NULL);\
        dispatch_async(queue, ^{
            NSData* imageData = [CacheFileManager getFileAtUrl:imageURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                [refreshIndicator removeFromSuperview];
                UIImageView* thumbView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
                thumbView.frame = CGRectMake(0,0,150,150);
                thumbView.contentMode = UIViewContentModeScaleToFill;
                [self insertSubview:thumbView belowSubview:caption];

            });
        });
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate didSelectPhoto:self];
}

@end
