    //
//  EditTags.m
//  GuardianNarratives
//
//  Created by Martyn Inglis on 19/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ArticleViewController.h"
#import "GuardianNarrativesAppDelegate.h"

@implementation ArticleViewController


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
	GuardianNarrativesAppDelegate *delegate = (GuardianNarrativesAppDelegate *) [[UIApplication sharedApplication]delegate];
	 	
	NSArray* resultsArray = [(NSDictionary* ) delegate.resultsDict objectForKey:@"results"];

	NSDictionary *article = [resultsArray objectAtIndex:index.row];
		
	NSDictionary *fields = [article objectForKey:@"fields"];
	
	//headline.text = [fields objectForKey:@"headline"];
	//trailText.text = [fields objectForKey:@"trailText"];
	self.title = @"Guardian Narratives: article";

	
	
	NSLog(@"headline %@", [fields objectForKey:@"headline"]);
	
	
	headline.text = @"TEST";
	
	NSLog(@"headline %@", headline);
	NSLog(@"trail %@", trailText);

	
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


- (void)dealloc {
	[headline release];
	[trailText release];
    [super dealloc];
}


@end
