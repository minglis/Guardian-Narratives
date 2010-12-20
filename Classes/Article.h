//
//  Article.h
//  GuardianNarratives
//
//  Created by Martyn Inglis on 20/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Article : NSObject {
	NSString *webTitle;
	NSString *headLine;
	NSString *trailText;
	NSString *webUrl;
	NSMutableArray *tags;
}

@property (nonatomic, retain) NSString *webTitle;
@property (nonatomic, retain) NSString *headline;
@property (nonatomic, retain) NSString *trailText;
@property (nonatomic, retain) NSString *webUrl;
@property (nonatomic, retain) NSMutableArray *tags;

@end
