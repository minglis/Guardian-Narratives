//
//  ASyncJSONDownloadOperation.m
//  MusicCribSheetPrototype
//
//  Created by Michael May on 16/12/2010.
//  Copyright 2010 Guardian News & Media. All rights reserved.
//
//	TODO: need to deal with all the failure conditions

#import "ASyncJSONDownloadOperation.h"
#import "JSON.h"

@implementation ASyncJSONDownloadOperation

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	NSString *JSONData = [[NSString alloc] initWithData:downloadedData encoding:NSUTF8StringEncoding];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSError *error;
	NSObject *JSONObj = [parser objectWithString:JSONData error:&error];
	
	NSLog(@"Parsed Object:%@", JSONObj);
	NSLog(@"IsDictionary:%d", [JSONObj isKindOfClass:[NSDictionary class]]);
	
	[target aSyncJSONDownloadDidFinishWithObject:JSONObj userInfo:userInfo];
	
	[parser release];	
	[JSONData release];
	
	[connection unscheduleFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

@end
