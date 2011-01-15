//
//  GSUrl.h
//  Google URL Shortener in Objective-c
//
//  Created by Marcio Giaxa Marinheiro on 14/01/11.
//  Copyright 2011 n/a. All rights reserved.
//

#import "JSON.h"
#define API_URI @"https://www.googleapis.com/urlshortener/v1/url"

@interface GSUrl : NSObject {
	NSString *_long_url;
	NSString *_short_url;
	NSString *_formatted_url;
}

-(GSUrl*) initWithString: (NSString*) url;
-(NSString*) shorten;

@end
