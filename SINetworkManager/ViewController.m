//
//  ViewController.m
//  SINetworkManager
//
//  Created by Shoya Ishimaru on 13/06/06.
//  Copyright (c) 2013年 Shoya Ishimaru. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    SINetworkManager *networkManager;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init
    networkManager = [[SINetworkManager alloc] init];
    [networkManager setUrl:@"http://markovlabo.net/post/"];
    networkManager.delegate = self;
    
    // Create dictionary
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"value1",@"key1",
                          @"value2",@"key2",
                          nil];
    
    // Send POST rewquest
    [networkManager sendPostRequestWithDictionary:dict];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark - SINetworkManagerDelegate

- (void)connectionSucceeded:(NSString *)respondData url:(NSString *)url
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"Received data from :%@",url);
    NSLog(@"%@",respondData);
    self.responseText.text = respondData;
}

- (void)connectionFailed:(NSString *)url
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"Missed connecting from :%@",url);
    self.responseText.text = @"Missed connecding";
}

@end
