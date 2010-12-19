//
//  GuardianNarrativesViewController.m
//  GuardianNarratives
//
//  Created by Martyn Inglis on 17/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GuardianNarrativesViewController.h"

@implementation GuardianNarrativesViewController;

@synthesize label;
@synthesize guardianLogo;
@synthesize displaySearchTerms;
@synthesize searchTerms;
@synthesize articles;

#pragma mark -
#pragma mark ASyncJSONDownloader Delegate


-(void)aSyncJSONDownloadDidFinishWithObject:(NSObject*)parsedJSONObject userInfo:(NSObject*)userInfo {
	NSLog(@"got JSON:%@", (NSDictionary*)parsedJSONObject);
	NSDictionary* parsedJSONDictionary = (NSDictionary*)parsedJSONObject;
	results = [parsedJSONDictionary retain];
	[articles reloadData];
}

#pragma mark -
#pragma mark GuardianNarrativesViewController

-(NSString*)urlEncodeString:(NSString*)string {
	NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)string,NULL,(CFStringRef)@"!*’();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
	
	return encodedString;
}


-(IBAction) submitSearch:(id) sender {
	if(searchTerms.text.length > 0) {
		NSString *searchTerm = [self urlEncodeString:[searchTerms text]];
		displaySearchTerms.text = [NSString stringWithFormat: @"You searched for %@", searchTerm];
		
		NSString* apiURL = [NSString stringWithFormat:@"http://content.guardianapis.com/search?q=%@&page-size=10&order-by=newest&format=json&show-fields=trailText&show-tags=all", searchTerm, 10];		
		[[ASyncJSONDownloader sharedASyncJSONDownloader] queueJSONDownloadFromURLString:apiURL target:self userInfo:@"Search"];
	}
	
	
}

#pragma mark -
#pragma mark UITableDataSource methods

- (NSInteger) tableView:(UITableView *)tv numberOfRowsInSection: (NSInteger) section {	
	NSDictionary* resultsDict = [results objectForKey:@"response"];
	NSLog(@"Results %@",  [resultsDict objectForKey:@"pageSize"]);
	return [[resultsDict objectForKey:@"pageSize"]intValue];
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *) indexPath {
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cell"] autorelease];
	}
		
	NSDictionary* resultsDict = [results objectForKey:@"response"];	

	if(indexPath.row < [[resultsDict objectForKey:@"pageSize"]intValue]) {
		NSArray* resultsArray = [(NSDictionary* ) resultsDict objectForKey:@"results"];
		NSDictionary *result = [resultsArray objectAtIndex:[indexPath row]];

		cell.textLabel.text = [result objectForKey:@"webTitle"]; 
	}
	
	return cell;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self.guardianLogo setImage:[UIImage imageNamed:@"guardian_logo.png"]];
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[label release];
	[button release];
	[guardianLogo release];
}

@end
