//
//  CacheFileManager.h
//  ShutterBug
//
//  Created by Puneet Goyal on 12/12/13.
//  Copyright (c) 2013 Puneet Goyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CacheFileDelegate <NSObject>

@required
- (NSData *)fetchFileForCachingFromURL:(NSURL *)url;

@end

@interface CacheFileManager : NSObject

@property (strong, atomic) NSFileManager *fileManager;
@property (strong, atomic) id<CacheFileDelegate> delegate;
+ (NSData *)getFileAtUrl:(NSURL *)url;

@end
