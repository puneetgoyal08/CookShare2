//
//  API.h
//  iReporter
//
//  Created by Fahim Farook on 9/6/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//


typedef void (^JSONResponseBlock)(NSDictionary* json);
typedef void (^connectionResponseBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);

@interface API :NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSMutableData *_responseData;
}

@property (strong, nonatomic) NSDictionary* user;
@property (strong, nonatomic) NSOperationQueue* queue;

+(API*)sharedInstance;
//check whether there's an authorized user
-(BOOL)isAuthorized;
//send an API command to the server
//-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;
-(NSURL*)urlForImageWithId:(NSNumber*)IdPhoto isThumb:(BOOL)isThumb;
-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(connectionResponseBlock)completionBlock;

@end
