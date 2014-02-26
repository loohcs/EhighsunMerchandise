//
//  ServiceArgs.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-23.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceArgs : NSObject

@property(nonatomic,copy) NSString *serviceURL;
@property(nonatomic,readonly) NSURL *webURL;
@property(nonatomic,copy) NSString *serviceNameSpace;
@property(nonatomic,copy) NSString *methodName;
@property(nonatomic,copy) NSString *soapMessage;
@property(nonatomic,readonly) NSMutableDictionary *headers;
//soapMessage处理
@property(nonatomic,readonly) NSString *defaultSoapMesage;
@property(nonatomic,retain) NSArray *soapParams;


- (id)initWithWebServiceName:(NSString *)ws_name andServiceNameSpace:(NSString *)serviceNameSpace andMethod:(NSString *)method andParams:(NSArray *)params;
-(NSString*)stringSoapMessage:(NSArray*)params;
+(ServiceArgs*)serviceMethodName:(NSString*)methodName;
+(ServiceArgs*)serviceMethodName:(NSString*)methodName soapMessage:(NSString*)soapMsg;
//webservice访问设置
+(void)setNameSapce:(NSString*)space;
+(void)setWebServiceURL:(NSString*)url;

//根据webService的具体名字，完善serviceURL
+(NSString *)getServiceURL:(NSString *)webServiceName;
@end
