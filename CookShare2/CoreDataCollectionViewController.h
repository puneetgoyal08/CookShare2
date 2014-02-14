//
//  CoreDataCollectionViewController.h
//  CookShare2
//
//  Created by Puneet Goyal on 13/02/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataCollectionViewController : UICollectionViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
- (void)performFetch;
@property (nonatomic) BOOL suspendAutomaticTrackingOfChangesInManagedObjectContext;

// Set to YES to get some debugging output in the console.
@property BOOL debug;


@end
