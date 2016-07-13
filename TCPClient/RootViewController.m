//
//  RootViewController.m
//  TCPClient
//
//  Created by pan on 14-10-15.
//  Copyright (c) 2014年 pan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    AsyncSocket *_clientSocket;
    NSMutableArray *_sockets;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _clientSocket = [[AsyncSocket alloc]initWithDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//连接到服务器
- (IBAction)onBtnConnectClick:(id)sender {
    
    NSError *error;
    
    if (_clientSocket.isConnected) {
        [_clientSocket disconnect];
    }
    
    if (![_clientSocket connectToHost:@"122.144.208.20" onPort:10080 error:&error]) {
        NSLog(@"连接服务器connectToHost fail: %@", error.localizedDescription);
    }
}

- (IBAction)onBtnSendClick:(id)sender {
    [_clientSocket writeData:[_text.text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1];
}

//建立连接
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"建立连接onScoket:%p did connecte to host:%@ on port:%d",sock,host,port);
    [sock readDataWithTimeout:1 tag:0];
}

//读取数据
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *aStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"读取数据aStr==%@",aStr);
    NSData *aData=[@"hello world" dataUsingEncoding:NSUTF8StringEncoding];
    [sock writeData:aData withTimeout:-1 tag:1];
    [sock readDataWithTimeout:1 tag:0];
}

//是否加密
-(void)onSocketDidSecure:(AsyncSocket *)sock
{
    NSLog(@"是否加密onSocket:%p did go a secure line:YES",sock);
}

//遇到错误时关闭连接
-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"遇到错误关闭连接onSocket:%p will disconnect with error:%@",sock,err);
}

//断开连接
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"断开连接onSocketDidDisconnect:%p",sock);
}
@end
