//
//  ViewController.h
//  SINetworkManager
//
//  Created by Shoya Ishimaru on 13/06/06.
//  Copyright (c) 2013年 Shoya Ishimaru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SINetworkManager.h"

@interface ViewController : UIViewController<SINetworkManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *responseText;

@end
