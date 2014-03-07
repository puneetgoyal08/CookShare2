//
//  VacationHelper.m
//  ShutterBug
//
//  Created by Puneet Goyal on 17/12/13.
//  Copyright (c) 2013 Puneet Goyal. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper()

@end

@implementation CoreDataHelper

@synthesize documents = _documents;

/*
 * Returns the documents url in NSDocuments Directory of the application
 */

+ (NSURL *)documentURL
{
    NSArray* documentDir =[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL* dirURL = [documentDir lastObject];
    return dirURL;
}

+ (void)openDocument:(UIManagedDocument *)document usingBlock:(IteratorBlock)iteratorBlock
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:[[document fileURL] path]]) {
        [document saveToURL:[document fileURL] forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            iteratorBlock(document);
        }];
    }
    else if ([document documentState]==UIDocumentStateClosed) {
        [document openWithCompletionHandler:^(BOOL success) {
            if(!success)
                NSLog(@"opening document with completion handler not successful");
            iteratorBlock(document);
        }];
    } else if ([document documentState]==UIDocumentStateNormal) {
        iteratorBlock(document);
        //document is already opened
    }

}

+ (NSArray *) listOfDocuments
{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[self documentURL] includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
}

+(NSString *)nameForFirstDocument
{
    if([[self listOfDocuments] count]==0)
        return nil;
    NSString *vacationName = [[[[self listOfDocuments] objectAtIndex:0] pathComponents] lastObject];
    return vacationName;
}

@end