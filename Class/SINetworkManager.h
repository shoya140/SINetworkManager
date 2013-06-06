//
//  SINetworkManager.h
//  SINetworkManager
//
//  Created by Shoya Ishimaru on 13/06/06.
//  Copyright (c) 2013年 Shoya Ishimaru. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SINetworkManagerDelegate <NSObject>

- (void)connectionSucceeded:(NSString *)respondData url:(NSString *)url;
- (void)connectionFailed:(NSString *)url;

@end

@interface SINetworkManager : NSObject{
    NSMutableData *buffer;
}

@property(nonatomic, weak) id <SINetworkManagerDelegate> delegate;
@property(nonatomic, retain) NSString *url;

- (void)sendPostRequestWithDictionary:(NSDictionary *)dictionary;

@end
