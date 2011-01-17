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
	NSMutableURLRequest *prepared_request = [self prepareRequest];
	NSData *response_data = [NSURLConnection sendSynchronousRequest:prepared_request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response_data encoding:NSASCIIStringEncoding];
	NSString *shortened_url = [NSString stringWithString:[[parser objectWithString:json_string] valueForKey:@"id"]];
	
	return shortened_url;
}

-(void) prepareUrl {
	_formatted_url = [NSString stringWithFormat:@"{ \"longUrl\":\"%@\"}", _long_url];
}

-(NSMutableURLRequest*) prepareRequest {	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: API_URI]];
	
	[request setHTTPMethod:@"POST"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:[[NSString stringWithString:_formatted_url] dataUsingEncoding:NSASCIIStringEncoding]];
	
	return request;
}

@end
