//
//  ArticleController.h
//  GuardianNarratives
//
//  Created by Martyn Inglis on 19/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArticleController : UIViewController <UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate> {
	NSIndexPath *index;
	IBOutlet UIImageView *guardianLogo;
	IBOutlet UILabel *headline;
	IBOutlet UILabel *trailText;
	IBOutlet UIWebView *articlePage;
	IBOutlet UITableView *tags;
}

@property (nonatomic, retain) IBOutlet UIImageView *guardianLogo;
@property (nonatomic, retain) IBOutlet UITableView *tags;

- (id) initWithIndexPath:(NSIndexPath *) indexPath;

@end
