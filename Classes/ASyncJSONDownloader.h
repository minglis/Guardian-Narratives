//
//  ASyncJSONDownloader.h
//  MusicCribSheetPrototype
//
//  Created by Michael May on 16/12/2010.
//  Copyright 2010 Guardian News & Media. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASyncJSONDownloadOperation.h"

@interface ASyncJSONDownloader : NSObject {
	NSOperationQueue *operationQueue;
}

+ (ASyncJSONDownloader*)sharedASyncJSONDownloader;

-(void)queueJSONDownloadFromURLString:(NSString*)urlString target:(id<ASyncDownloadOperationDelegate>)target userInfo:(NSObject*)userInfo;

-(void)queueDownloadFromURLString:(NSString *)urlString target:(id <ASyncDownloadOperationDelegate>)target userInfo:(NSObject *)userInfo;

@end
