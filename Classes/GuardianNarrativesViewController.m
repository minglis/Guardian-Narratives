//
//  GuardianNarrativesViewController.m
//  GuardianNarratives
//
//  Created by Martyn Inglis on 17/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GuardianNarrativesViewController.h"
#import "GuardianNarrativesAppDelegate.h"
#import "ArticleController.h"
#import "Article.h";

@implementation GuardianNarrativesViewController;

@synthesize label;
@synthesize guardianLogo;
@synthesize displaySearchTerms;
@synthesize searchTerms;
@synthesize articles;
@synthesize resultsMessage;

#pragma mark -
#pragma mark ASyncJSONDownloader Delegate


-(void)aSyncJSONDownloadDidFinishWithObject:(NSObject*)parsedJSONObject userInfo:(NSObject*)userInfo {
	
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];
	
	tagCounts = [[NSMutableDictionary alloc] init];
	delegate.tags = [[NSMutableArray alloc]init];
	delegate.stripTags = [[NSMutableArray alloc]init];
	delegate.resultsArray = [[NSMutableArray alloc]init];
	
	NSDictionary* parsedJSONDictionary = (NSDictionary*)parsedJSONObject;
	results = [parsedJSONDictionary retain];
	
	delegate.resultsDict = [results objectForKey:@"response"]; 
	
	NSArray* resultsArray = [(NSDictionary* ) delegate.resultsDict objectForKey:@"results"];

	for(int i = 0; i < [resultsArray count]; i++) {
		NSMutableArray *tags = [[NSMutableArray alloc]init];
		NSDictionary *result = [resultsArray objectAtIndex:i];
		NSDictionary *fields = [result objectForKey:@"fields"];
		NSArray *tagsForArticleArray = [result objectForKey:@"tags"];
		
		Article *article = [[Article alloc]init];
				
		article.webUrl = [result objectForKey:@"webUrl"];
		article.headline = [fields objectForKey:@"headline"];
		article.webTitle = [result objectForKey:@"webTitle"];
		article.trailText = [fields objectForKey:@"trailText"];
		
		for(int j=0; j<[tagsForArticleArray count]; j++) {
			NSDictionary *tag = [tagsForArticleArray objectAtIndex:j];
			NSString *tagType = [tag objectForKey:@"type"];
			if([tagType isEqualToString:@"keyword"]) {

				NSString *tagId = [tag objectForKey:@"id"];
				
				[tags addObject:tagId];
				
				if(![delegate.tags containsObject:tagId]) {
					[delegate.tags addObject:tagId];
				}				
			}			
		}
		article.tags = tags;		
		[delegate.resultsArray addObject:article];
		[article release];
		
	}

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
		
		NSString* apiURL = [NSString stringWithFormat:@"http://content.guardianapis.com/search?q=%@&page-size=50&order-by=newest&format=json&show-fields=trailText,headline&show-tags=all", searchTerm, 10];		
		[[ASyncJSONDownloader sharedASyncJSONDownloader] queueJSONDownloadFromURLString:apiURL target:self userInfo:@""];
	}
}

-(IBAction) submitTagSearch:(id) sender {	
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate*) [[UIApplication sharedApplication] delegate];

	NSMutableArray *articlesToRemove = [[NSMutableArray alloc]init];
	
	for(int i=0; i<[delegate.resultsArray count]; i++) {
		Article *article = [delegate.resultsArray objectAtIndex:i];
		for(int j=0; j<[delegate.stripTags count]; j++) {
			if([article.tags containsObject:[delegate.stripTags objectAtIndex:j]]) {
				[articlesToRemove addObject:[delegate.resultsArray objectAtIndex:i]];
			}
		}
	}
	
	for(int i=0;i<[articlesToRemove count];i++) {
		[delegate.resultsArray removeObject:[articlesToRemove objectAtIndex:i]];
	}
	
	[articles reloadData];
}

#pragma mark -
#pragma mark UITableDataSource methods


- (void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *) indexPath {
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate*) [[UIApplication sharedApplication] delegate];
	ArticleController *articleController = [[ArticleController alloc]initWithIndexPath:indexPath];
	
	[delegate.navController pushViewController:articleController animated:YES];
	[articleController release];
	[tv deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger) tableView:(UITableView *)tv numberOfRowsInSection: (NSInteger) section {
	NSDictionary* resultsDict = [results objectForKey:@"response"];
	return [[resultsDict allKeys]count];
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *) indexPath {
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cell"] autorelease];
	}
	
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];
	
	if([delegate.resultsArray count] > 0) {
		if(indexPath.row < [delegate.resultsArray count]) {
			Article *article = [delegate.resultsArray objectAtIndex:[indexPath row]];
			cell.textLabel.text = article.webTitle;			
		}
	}
	resultsMessage.text = [NSMutableString stringWithFormat:@"Results: %d", [delegate.resultsArray count]];    
	
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
	self.title = @"Guardian Narratives: search";
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
	[tagCounts release];
	[button release];
	[resultsMessage release];
	[articles release];
	[searchTerms release];
	[displaySearchTerms release];
	[guardianLogo release];
}

@end
