//
//  HTTPRequest.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-19.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "HTTPRequest.h"

@implementation HTTPRequest


-(HTTPRequest *)initWithURlString:(NSString *)urlStr
{
    self=[super init];
    if (self)
    {
        NSURL *url=[NSURL URLWithString:urlStr];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    return self;
}

//块方法
-(void)setBlock:(Block_fun)aBlock
{
    if (block_data!=aBlock)
    {
        Block_release(block_data);
        block_data=Block_copy(aBlock);
    }
}

//响应请求
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receiveData=[[NSMutableData alloc] initWithCapacity:0];
    AllLength=[response expectedContentLength];
}

//下载数据时调用的方法
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}

//下载完毕时调用
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //下载完毕要做的事
    // [self.delegate sendReceiveData:receiveData];
    if (block_data)
    {
        block_data(receiveData,0);
    }
}

//网络链接出错时调用
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"出错原因：%@", [error localizedDescription]);
}

- (void)dealloc
{
    [receiveData release];
    Block_release(block_data);
    [super dealloc];
}

@end


