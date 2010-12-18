//
//  ASyncDownloadOperation.m
//  MusicCribSheetPrototype
//
//  Created by Michael May on 16/12/2010.
//  Copyright 2010 Guardian News & Media. All rights reserved.
//
//	TODO: need to deal with all the failure conditions

#import "ASyncDownloadOperation.h"
#import "JSON.h"

@interface ASyncDownloadOperation ()

@property (copy, nonatomic) NSURLRequest *urlRequest;
@property (retain, nonatomic) NSObject *userInfo;

@end


@implementation ASyncDownloadOperation

@synthesize urlRequest, userInfo;

-(id)init {
	NSLog(@"Do not use init with these objects, use initWithURLRequest:");
	
	return nil;
}

-(id)initWithURLString:(NSString*)aURLString target:(id<ASyncDownloadOperationDelegate>)aTarget userInfo:(NSObject*)aUserInfo {
	if((self = [super init])) {
		urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:aURLString]];
		
		userInfo = [aUserInfo retain];
		
		target = aTarget;
	}
	
	return self;
}

- (void)dealloc {
    [urlRequest release], urlRequest = nil;
	[userInfo release], userInfo = nil;
	[downloadedData release], downloadedData = nil;
	
	target = nil;
	
    [super dealloc];
}

#pragma mark -

- (void)main {
	if(self.urlRequest != nil && self.isCancelled == NO) {
		NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.urlRequest delegate:self startImmediately:NO];
		
		if(connection) {
			downloadedData = [[NSMutableData alloc] initWithLength:0];
			
			[connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
			
			[connection start];
			
			[connection release];
		}
	}
}

#pragma mark -
#pragma mark NSURLConnection Delegate

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
	NSLog(@"willSendRequest:%@", request);
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"didReceiveResponse:%@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"got some data from %@", self.urlRequest);
	
	// TODO: check cancelled state and cancel the connection if needs be
	
	[downloadedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError:%@", error);
	
	[connection unscheduleFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[target aSyncDownloadDidFinishWithObject:downloadedData userInfo:userInfo];
		
	[connection unscheduleFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


@end

