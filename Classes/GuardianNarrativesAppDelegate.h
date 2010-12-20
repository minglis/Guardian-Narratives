//
//  GuardianNarrativesAppDelegate.h
//  GuardianNarratives
//
//  Created by Martyn Inglis on 17/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuardianNarrativesViewController;

@interface GuardianNarrativesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GuardianNarrativesViewController *viewController;
	UINavigationController *navController;
	NSDictionary* resultsDict;
	NSMutableArray *resultsArray;
	NSMutableArray* tags;
	NSMutableArray* stripTags;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GuardianNarrativesViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) NSDictionary *resultsDict;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSMutableArray *resultsArray;
@property (nonatomic, retain) NSMutableArray *stripTags;

@end

