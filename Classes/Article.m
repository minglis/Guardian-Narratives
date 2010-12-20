//
//  Article.m
//  GuardianNarratives
//
//  Created by Martyn Inglis on 20/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Article.h"


@implementation Article

@synthesize webUrl;
@synthesize headline;
@synthesize trailText;
@synthesize webTitle;
@synthesize tags;

- (void) dealloc {
	[webUrl release];
	[headline release];
	[trailText release];
	[webTitle release];
	[tags release];
	[super dealloc];
}

@end
