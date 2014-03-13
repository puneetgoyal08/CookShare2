//
//  API.h
//  CookShare2
//
//  Created by Puneet Goyal on 21/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//


typedef void (^JSONResponseBlock)(NSDictionary* json);
typedef void (^connectionResponseBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);

@interface API :NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSMutableData *_responseData;
}

@property (strong, nonatomic) NSDictionary* user;
@property (strong, nonatomic) NSOperationQueue* queue;
@property (strong, nonatomic) NSNumber* numberOfPhotos;

+(API*)sharedInstance;
//check whether there's an authorized user
-(BOOL)isAuthorized;
//send an API command to the server
//-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;
-(NSURL*)urlForImageWithId:(NSNumber*)IdPhoto isThumb:(BOOL)isThumb;
-(void)commandWithParams:(NSDictionary *)params onCompletion:(connectionResponseBlock)completionBlock;

@end
