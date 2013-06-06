//
//  SINetworkManager.m
//  SINetworkManager
//
//  Created by Shoya Ishimaru on 13/06/06.
//  Copyright (c) 2013年 Shoya Ishimaru. All rights reserved.
//

#import "SINetworkManager.h"

#define DUMMY_URL @"http://markovlabo.net/post/"

@implementation SINetworkManager

- (void)sendPostRequestWithDictionary:(NSDictionary *)dictionary
{
    if (!self.url) {
        self.url = [NSURL URLWithString:DUMMY_URL];
    }

    NSString *requestString = [[NSString alloc] init];
    for (id key in dictionary) {
        requestString = [requestString stringByAppendingFormat:@"%@=%@&",key,[dictionary objectForKey:key]];
    }
    NSData *postData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        buffer = [NSMutableData data];
    }else{
        //TODO:error handlong
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)res {
    NSHTTPURLResponse *hres = (NSHTTPURLResponse *)res;
    NSLog(@"--Connection info------");
    NSLog(@"Received Response. Status Code: %d", [hres statusCode]);
    NSLog(@"Expected ContentLength: %qi", [hres expectedContentLength]);
    NSLog(@"MIMEType: %@", [hres MIMEType]);
    NSLog(@"Suggested File Name: %@", [hres suggestedFilename]);
    NSLog(@"Text Encoding Name: %@", [hres textEncodingName]);
    NSLog(@"URL: %@", [hres URL]);
    NSLog(@"Received Response. Status Code: %d", [hres statusCode]);
    NSDictionary *dict = [hres allHeaderFields];
    NSArray *keys = [dict allKeys];
    for (int i = 0; i < [keys count]; i++) {
        NSLog(@"  %@: %@",
              [keys objectAtIndex:i],
              [dict objectForKey:[keys objectAtIndex:i]]);
    }
    NSLog(@"--Connection info end--");
    [buffer setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)receivedData {
    [buffer appendData:receivedData];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    connection = nil;
    buffer = nil;
    NSLog(@"Connection failed: %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
    [self.delegate connectionFailed:self.url];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Succeed!! Received %d bytes of data", [buffer length]);
    NSString *contents = [[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding];
    buffer = nil;
    [self.delegate connectionSucceeded:contents url:self.url];
}

@end
