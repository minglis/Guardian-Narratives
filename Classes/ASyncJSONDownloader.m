//
//  ASyncJSONDownloader.m
//  MusicCribSheetPrototype
//
//  Created by Michael May on 16/12/2010.
//  Copyright 2010 Guardian News & Media. All rights reserved.
//

#import "ASyncJSONDownloader.h"

@implementation ASyncJSONDownloader

#pragma mark -
#pragma mark Singleton

// from https://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/CocoaFundamentals/CocoaObjects/CocoaObjects.html%23//apple_ref/doc/uid/TP40002974-CH4-SW32

static ASyncJSONDownloader *sharedASyncJSONDownloader = nil;

+ (ASyncJSONDownloader*)sharedASyncJSONDownloader
{
    if (sharedASyncJSONDownloader == nil) {
        sharedASyncJSONDownloader = [[super allocWithZone:NULL] init];
    }
    return sharedASyncJSONDownloader;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedASyncJSONDownloader] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

#pragma mark -

-(void)queueJSONDownloadFromURLString:(NSString*)urlString target:(id<ASyncDownloadOperationDelegate>)target  userInfo:(NSObject*)userInfo {
	ASyncJSONDownloadOperation *downloadOperation = [[ASyncJSONDownloadOperation alloc] initWithURLString:urlString target:target userInfo:userInfo];
	
	[operationQueue addOperation:downloadOperation];
	
	[downloadOperation release];
}

-(void)queueDownloadFromURLString:(NSString*)urlString target:(id<ASyncDownloadOperationDelegate>)target  userInfo:(NSObject*)userInfo {
	ASyncDownloadOperation *downloadOperation = [[ASyncDownloadOperation alloc] initWithURLString:urlString target:target userInfo:userInfo];
	
	[operationQueue addOperation:downloadOperation];
	
	[downloadOperation release];
}

-(void)cancelQueuedDownloads {
	[operationQueue cancelAllOperations];
}

#pragma mark -

-(id)init {
	if((self = [super init])) {
		operationQueue = [[NSOperationQueue alloc] init];	
		
		[operationQueue setMaxConcurrentOperationCount:1];
	}
	
	return self;
}

-(void)dealloc {
	[operationQueue release];
	
	[super dealloc];
}

@end
