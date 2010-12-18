//
//  ASyncDownloadOperation.h
//  MusicCribSheetPrototype
//
//  Created by Michael May on 17/12/2010.
//  Copyright 2010 Guardian News & Media. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ASyncDownloadOperationDelegate
-(void)aSyncDownloadDidFinishWithObject:(NSObject*)object userInfo:(NSObject*)userInfo;
-(void)aSyncJSONDownloadDidFinishWithObject:(NSObject*)object userInfo:(NSObject*)userInfo;
@end


@interface ASyncDownloadOperation : NSOperation {
@protected	
	NSURLRequest	*urlRequest;
	NSMutableData	*downloadedData;
	
	id<ASyncDownloadOperationDelegate>	target;
	NSObject		*userInfo;
}

@property (readonly, copy, nonatomic) NSURLRequest *urlRequest;
@property (readonly, retain, nonatomic) NSObject *userInfo;

-(id)initWithURLString:(NSString*)urlString target:(id<ASyncDownloadOperationDelegate>)target userInfo:(NSObject*)userInfo;

@end
