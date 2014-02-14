//
//  VacationHelper.h
//  ShutterBug
//
//  Created by Puneet Goyal on 17/12/13.
//  Copyright (c) 2013 Puneet Goyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject
typedef void (^ IteratorBlock)(UIManagedDocument *);

@property (strong, atomic) NSDictionary *documents;

+ (NSArray *)listOfDocuments;
//+ (void)openDocument : (NSString *)documentName usingBlock:(IteratorBlock)iteratorBlock;
+ (NSString *)nameForFirstDocument;
+ (void)openDocument : (UIManagedDocument *)document usingBlock: (IteratorBlock)iteratorBlock;
@end
