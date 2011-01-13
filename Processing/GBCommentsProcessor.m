//
//  GBCommentsProcessor.m
//  appledoc
//
//  Created by Tomaz Kragelj on 27.8.10.
//  Copyright (C) 2010, Gentle Bytes. All rights reserved.
//

#import "RegexKitLite.h"
#import "GBApplicationSettingsProvider.h"
#import "GBStore.h"
#import "GBDataObjects.h"
#import "GBCommentsProcessor.h"

@interface GBCommentsProcessor ()

@property (retain) id<GBObjectDataProviding> currentContext;
@property (retain) GBStore *store;
@property (retain) GBApplicationSettingsProvider *settings;

@end

#pragma mark -

@implementation GBCommentsProcessor

#pragma mark Initialization & disposal

+ (id)processorWithSettingsProvider:(id)settingsProvider {
	return [[[self alloc] initWithSettingsProvider:settingsProvider] autorelease];
}

- (id)initWithSettingsProvider:(id)settingsProvider {
	NSParameterAssert(settingsProvider != nil);
	GBLogDebug(@"Initializing comments processor with settings provider %@...", settingsProvider);
	self = [super init];
	if (self) {
		self.settings = settingsProvider;
	}
	return self;
}

#pragma mark Processing handling

- (void)processComment:(GBComment *)comment withStore:(id)store {
	[self processComment:comment withContext:nil store:store];
}

- (void)processComment:(GBComment *)comment withContext:(id<GBObjectDataProviding>)context store:(id)store {
	NSParameterAssert(comment != nil);
	NSParameterAssert(store != nil);
	
	GBLogDebug(@"Processing %@...", comment);
	self.currentContext = context;
	self.store = store;	
	
	NSArray *lines = [comment.stringValue arrayOfLines];
	GBLogDebug(@"Comment has %u lines.", [lines count]);
	
	//__block GBCommentParagraph *paragraph = nil;
	[lines enumerateObjectsUsingBlock:^(NSString *line, NSUInteger idx, BOOL *stop) {
		GBLogDebug(@"Processing line %u: '%@'...", idx + 1, [line normalizedDescription]);
		
	}];	

	self.currentContext = nil;
}

#pragma mark Helper methods

#pragma mark Properties

@synthesize currentContext;
@synthesize settings;
@synthesize store;

@end
