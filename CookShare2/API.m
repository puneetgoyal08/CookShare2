//
//  API.m
//  CookShare2
//
//  Created by Puneet Goyal on 21/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "API.h"

//the web location of the service
#define kAPIHost @"http://dcetech.com"
#define kAPIPath @"puneet/iReporter/"

@implementation API

@synthesize user;

#pragma mark - Singleton methods
/**
 * Singleton methods
 */
+(API*)sharedInstance {
    static API *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.queue = [[NSOperationQueue alloc] init];
        sharedInstance.numberOfPhotos = [[NSNumber alloc] initWithInt:0];
    });
    
    return sharedInstance;
}

#pragma mark - init

-(API*)init {
    self = [super init];
    if (self != nil) {
        user = nil;
    }
    return self;
}


-(BOOL)isAuthorized {
    return [[user objectForKey:@"IdUser"] intValue]>0;
}

-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(connectionResponseBlock)completionBlock {
    NSMutableURLRequest *request2 = [self setData:params];
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request2 delegate:self];
    [NSURLConnection sendAsynchronousRequest:request2 queue:self.queue completionHandler:completionBlock];
    //start the connection
    //  [connection start];
}

-(NSMutableURLRequest *)setData: (NSMutableDictionary *)params{
    NSData *imageData = nil;
    if ([params objectForKey:@"file"]) {
        UIImage *img = [params objectForKey:@"file"];
        imageData = UIImageJPEGRepresentation(img, 0.1);
		[params removeObjectForKey:@"file"];
	}

    NSURL *url = [NSURL URLWithString:@"http://dcetech.com/puneet/iReporter/index.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"YOUR_BOUNDARY_STRING";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    for(NSString *key in params){
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@", key,[params objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
    }

    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"photo.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }

    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    return request;
}

-(NSURL*)urlForImageWithId:(NSNumber*)IdPhoto isThumb:(BOOL)isThumb {
    NSString* urlString = [NSString stringWithFormat:@"%@/%@upload/%@%@.jpg", kAPIHost, kAPIPath, IdPhoto, (isThumb)?@"-thumb":@""];
    return [NSURL URLWithString:urlString];
}

#pragma mark - NSURLConnection Delegate methods

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}

@end
