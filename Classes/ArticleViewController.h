//
//  EditTags.h
//  GuardianNarratives
//
//  Created by Martyn Inglis on 19/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArticleViewController : UIViewController {
	NSIndexPath *index;
	IBOutlet UILabel* headline;
	IBOutlet UILabel* trailText;
	
}


- (id) initWithIndexPath:(NSIndexPath *) indexPath;

@end
