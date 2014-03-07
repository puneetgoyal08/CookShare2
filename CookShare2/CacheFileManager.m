//
//  CacheFileManager.m
//  ShutterBug
//
//  Created by Puneet Goyal on 12/12/13.
//  Copyright (c) 2013 Puneet Goyal. All rights reserved.
//


#import "CacheFileManager.h"
#import <CoreData/CoreData.h>

@implementation CacheFileManager

@synthesize fileManager = _fileManager;

- (NSFileManager *)fileManager
{
    if(_fileManager == nil)
        return [[NSFileManager alloc] init];
    else
        return _fileManager;
}

- (void)setFileManager:(NSFileManager *)fileManager
{
    _fileManager = fileManager;
}

+ (NSURL *)getDocumentURL:(NSURL *)url
{
    NSFileManager* fm = [NSFileManager defaultManager];
    NSArray* appCacheDir =[fm URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *documenturl = nil;
    if(url!=nil)
    documenturl = [[appCacheDir lastObject] URLByAppendingPathComponent:[[url pathComponents] lastObject]];
     return documenturl;
}

+ (NSString *)getDocumentPath:(NSURL *)url
{
    NSFileManager* fm = [NSFileManager defaultManager];
    NSArray* appCacheDir =[fm URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL* dirURL = [appCacheDir lastObject];
    NSString* dirPath = [dirURL path];
    NSString *documentPath;
    if(url!=nil)
        documentPath = [dirPath stringByAppendingPathComponent:[[url pathComponents] lastObject]];
    return documentPath;
}

+ (void)fetchDataFromURL:(NSURL *)url
{
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    if([[NSFileManager defaultManager] createFileAtPath:[self getDocumentPath:url] contents:data attributes:nil]) {
        NSLog(@"working");
    } else {
        NSLog(@"Not working");
    }
}

+ (NSData *)getFileAtUrl:(NSURL *)url
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self getDocumentPath:url]]) {
        // does not exist on disk, so create it
        [self fetchDataFromURL:url];
    }
    NSURL *documentURL = [self getDocumentURL:url];
    NSData* data = [[NSData alloc] initWithContentsOfURL:documentURL];
    return data;
}

@end
