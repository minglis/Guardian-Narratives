//
//  GuardianNarrativesViewController.h
//  GuardianNarratives
//
//  Created by Martyn Inglis on 17/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASyncJSONDownloader.h"


@interface GuardianNarrativesViewController : UIViewController <UITextFieldDelegate, ASyncDownloadOperationDelegate, UITableViewDataSource, UITableViewDelegate>{
	IBOutlet UILabel *label;
	IBOutlet UILabel *displaySearchTerms;
	IBOutlet UILabel *resultsMessage;
	IBOutlet UITextField *searchTerms;
	UIButton *button;
	IBOutlet UIImageView *guardianLogo;
	NSObject *results;
	IBOutlet UITableView *articles;
	NSMutableDictionary *tagCounts;
}

@property (nonatomic, retain) IBOutlet UITableView *articles;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UILabel *resultsMessage;
@property (nonatomic, retain) IBOutlet UILabel *displaySearchTerms;
@property (nonatomic, retain) IBOutlet UITextField *searchTerms;
@property (nonatomic, retain) IBOutlet UIImageView *guardianLogo;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

- (IBAction) submitSearch:(id) sender;
- (IBAction) submitTagSearch:(id) sender;

@end

