//
//  API.m
//  iReporter
//
//  Created by Fahim Farook on 9/6/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
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

//-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock {
//	NSData* uploadFile = nil;
//	if ([params objectForKey:@"file"]) {
//		uploadFile = (NSData*)[params objectForKey:@"file"];
//		[params removeObjectForKey:@"file"];
//	}
//
//    NSMutableURLRequest *apiRequest = [self multipartFormRequestWithMethod:@"POST" path:kAPIPath parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
//		if (uploadFile) {
//			[formData appendPartWithFileData:uploadFile name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
//		}
//	}];
//    AFJSONRequestOperation* operation = [[AFJSONRequestOperation alloc] initWithRequest: apiRequest];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //success!
//        completionBlock(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //failure :(
//        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
//    }];
//    [operation start];
//}

-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(connectionResponseBlock)completionBlock {
	NSData* uploadFile = nil;
	if ([params objectForKey:@"file"]) {
		uploadFile = (NSData*)[params objectForKey:@"file"];
		[params removeObjectForKey:@"file"];
	}
    NSURL *url = [NSURL URLWithString:@"http://dcetech.com/puneet/iReporter/index.php"];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/xml; charset=urf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *stringData = [[NSString alloc] initWithString:[NSString stringWithFormat:@"command=%@&username=%@&password=%@", [params objectForKey:@"command"], [params objectForKey:@"username"], [params objectForKey:@"password"]]];
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    NSMutableURLRequest *request2 = [self setData:params];
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request2 delegate:self];
    [NSURLConnection sendAsynchronousRequest:request2 queue:self.queue completionHandler:completionBlock];
    
    //start the connection
    //  [connection start];
    
}

-(NSMutableURLRequest *)setData: (NSMutableDictionary *)params{
    NSData *imageData = nil;
    if ([params objectForKey:@"file"]) {
		imageData = (NSData*)[params objectForKey:@"file"];
		[params removeObjectForKey:@"file"];
	}

    NSURL *url = [NSURL URLWithString:@"http://dcetech.com/puneet/iReporter/index.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"YOUR_BOUNDARY_STRING";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"command\"\r\n\r\n%@", [params objectForKey:@"command"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n%@", [params objectForKey:@"username"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n%@", [params objectForKey:@"password"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", @"photo.jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
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

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}
@end
