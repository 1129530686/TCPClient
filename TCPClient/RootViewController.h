//
//  RootViewController.h
//  TCPClient
//
//  Created by pan on 14-10-15.
//  Copyright (c) 2014年 pan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"

@interface RootViewController : UIViewController <AsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *text;
- (IBAction)onBtnConnectClick:(id)sender;
- (IBAction)onBtnSendClick:(id)sender;

@end
