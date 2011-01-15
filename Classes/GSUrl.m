//
//  GSUrl.m
//  Google URL Shortener in Objective-c
//
//  Created by Marcio Giaxa Marinheiro on 14/01/11.
//  Copyright 2011 n/a. All rights reserved.
//

#import "GSUrl.h"

@interface GSUrl (Private)
- (NSMutableURLRequest*) prepareRequest;
- (void) prepareUrl;
@end


@implementation GSUrl

-(GSUrl*) initWithString:(NSString *)url {
	_long_url = url;
	return self;
}

-(NSString*) shorten {
	[self prepareUrl];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSMutableURLRequest *preparedRequest = [self prepareRequest];
	NSData *responseData = [NSURLConnection sendSynchronousRequest:preparedRequest returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
	
	return [[parser objectWithString:json_string] valueForKey:@"id"];
}

-(void) prepareUrl {
	_formatted_url = [[NSString alloc] initWithFormat:@"{ \"longUrl\":\"%@\"}", _long_url];
}

-(NSMutableURLRequest*) prepareRequest {	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: API_URI]];
	
	[request setHTTPMethod:@"POST"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:[[NSString stringWithString:_formatted_url] dataUsingEncoding:NSASCIIStringEncoding]];
	
	return request;
}

@end
