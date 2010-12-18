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
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GuardianNarrativesViewController *viewController;

@end

