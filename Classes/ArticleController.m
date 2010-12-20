    //
//  ArticleController.m
//  GuardianNarratives
//
//  Created by Martyn Inglis on 19/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ArticleController.h"
#import "GuardianNarrativesAppDelegate.h"
#import "Article.h";


@implementation ArticleController
@synthesize guardianLogo;
@synthesize tags;

- (id) initWithIndexPath:(NSIndexPath *)indexPath {
	
	if(self == [super init]) {
		index = indexPath;
	}
	return self;
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Guardian Narratives: article";
	[guardianLogo setImage:[UIImage imageNamed:@"guardian_logo.png"]];
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];
		
	Article *article = [delegate.resultsArray objectAtIndex:index.row];
			
	headline.text = article.headline;
	trailText.text = article.trailText;
	
	articlePage.delegate = self;
	[articlePage loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:article.webUrl]]];
	
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem.title = @"Edit Search Tags";
	
    [super viewDidLoad];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark Table Methods

- (void) tableView:(UITableView *) tv commitEditingStyle:(UITableViewCellEditingStyle) editing forRowAtIndexPath: (NSIndexPath *) indexPath {
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];
	NSArray *keys = delegate.tags;
	
	if(editing == UITableViewCellEditingStyleDelete) {
		NSString *keyToRemove = [keys objectAtIndex:indexPath.row];
		[delegate.stripTags addObject:keyToRemove];
		[delegate.tags removeObjectAtIndex:indexPath.row];

		[tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
	}
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tv editingStyleForRowAtIndexPath:(NSIndexPath *) indexPath {
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];

	NSArray *keys = delegate.tags;
	NSInteger count = (NSInteger)[keys count];
	if(indexPath.row < count) {
		return UITableViewCellEditingStyleDelete;
	} else {
		return UITableViewCellEditingStyleInsert;
	}
}

- (NSInteger) tableView:(UITableView *)tv numberOfRowsInSection: (NSInteger) section {	
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];

	NSArray *keys = delegate.tags;
	NSInteger count = (NSInteger)[keys count];	
	
	if(self.editing) {
		count = count + 1;
	}
	
	return count;
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *) indexPath {
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cell"] autorelease];
	}
	
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];
	NSArray *keys = delegate.tags;

	if(indexPath.row < [keys count]) {
		cell.textLabel.text = [keys objectAtIndex:indexPath.row];
	} 
	
	return cell;
}

-(void) setEditing:(BOOL)editing animated:(BOOL) animated {
	
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];
	
	[super setEditing:editing animated:animated];
	[tags setEditing:editing animated:animated];
	
	NSMutableArray *indexes = [[NSMutableArray alloc]init];
	[indexes autorelease];
	
	for(int i=0; i<[delegate.tags count]; i++) {
		[indexes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
	}
	
	NSArray *lastIndex = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[delegate.tags count] inSection:0]];

	if(editing != self.editing) {
		[super setEditing:editing animated:animated];
		[tags setEditing:editing animated:animated];	
		
		if(editing == NO) {
			[tags deleteRowsAtIndexPaths:lastIndex withRowAnimation:indexes withRowAnimation:UITableViewRowAnimationLeft];
		} 
	}
	[tags reloadData];
		
}

- (void)dealloc {
    [articlePage release];
    [tags release];
    [guardianLogo release];
    [headline release];
    [super dealloc];
}


@end
