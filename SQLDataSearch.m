//
//  SQLDataSearch.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-26.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "SQLDataSearch.h"
#import "JBCalendarDate.h"
@implementation SQLDataSearch

#warning mark -- 获取用户的信息字典，包括用户名，密码，以及一些特定属性，如表示浏览权限，职位等的属性
+ (NSMutableArray *)getUsrInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *primaryUserKey = [defaults objectForKey:@"primaryUserKey"];
    
    NSString *startTime = [defaults objectForKey:@"startTime"];
    NSString *endTime = [defaults objectForKey:@"endTime"];
    
    NSMutableArray *params = [[NSMutableArray alloc] init];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:primaryUserKey,@"primaryUserKey", nil]];

    if (startTime != nil & endTime != nil) {
        [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:startTime,@"startTime", nil]];
        [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:endTime,@"endTime", nil]];
    }
    else
    {
        JBCalendarDate *JBCalDate = [JBCalendarDate dateFromNSDate:[NSDate date]];
        NSString *date = [NSString stringWithFormat:@"%d-%d-%d", JBCalDate.year, JBCalDate.month, JBCalDate.day];
        [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:date,@"startTime", nil]];
        [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:date,@"endTime", nil]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:date forKey:@"startTime"];
        [defaults setObject:date forKey:@"endTime"];
    }
    
    
    return params;
}

+ (void)getDateStr:(NSString *)startTime andEndTime:(NSString *)endTime
{
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    
//    [mArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:startTime,@"startTime", nil]];
//    [mArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:endTime,@"endTime", nil]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:startTime forKey:@"startTime"];
    [defaults setObject:endTime forKey:@"endTime"];
}

+ (NSDictionary *)getStartTime:(NSDate *)startTime andEndTime:(NSDate *)endTime
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    return dic;
}

+ (NSString *)getPlistPath:(NSString *)fileName
{
    //获取沙盒中文件的路径
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [str stringByAppendingPathComponent:fileName];

    
    return path;
}


+ (NSString *)getPlistPath:(NSString *)fileName andType:(NSString *)type
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    
    return path;
}

+ (NSArray *)getTitle:(NSString *)titleKey
{
    //TODO:根据titleKey我们可以从数据库中得到我们具体需要的各种不同title，比如说在结算的页面，我们传入“结算汇总”，这样我们就可以得到结算汇总页面需要的表头：供应商名次，本期应结，本期销售，上期结余，月末应付，费用累计
    
    NSString *path = [SQLDataSearch getPlistPath:@"TitleInfo.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *titleArray = [dic objectForKey:titleKey];
        return titleArray;
    }
    else
    {
        return nil;
    }
}

+ (NSMutableDictionary *)getFloor:(NSString *)floorKey
{
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (int i = 0; i < 50; i++) {
        NSString *str = [NSString stringWithFormat:@"%@_%d", floorKey, i];
        [dataDic setValue:str forKey:floorKey];
    }
    return dataDic;
}

+ (NSMutableDictionary *)getShopCheck:(NSString *)checkKey
{
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    return dataDic;
}

//同步请求
+ (NSDictionary *)SyncGetDataWith:(NSString *)ws_name andServiceNameSpace:(NSString *)ws_namespace andMethod:(NSString *)method andParams:(NSArray *)params andPageTitle:(NSString *)pageTitle
{
    ServiceArgs *args=[[ServiceArgs alloc] initWithWebServiceName:ws_name andServiceNameSpace:ws_namespace andMethod:method andParams:params];
    ServiceResult *result=[ServiceHelper syncService:args];
    NSLog(@"同步请求xml=%@\n",result);
    NSLog(@"----------同步请求xml=%@\n",result.xmlString);
    
    /********[--如果无法解析，请启用以下两句--]**********
     NSString* xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
     [result.xmlParse setDataSource:xml];
     ****/
    
    NSString *nodeStr = [NSString stringWithFormat:@"//%@", [method substringFromIndex:3]];
    
    NSArray *arr=[result.xmlParse soapXmlSelectNodes:nodeStr];
    NSLog(@"解析xml结果=%@\n",arr);
    
    NSDictionary *dic = [DBDataHelper getData:arr andValueArrName:pageTitle];
    NSLog(@"%@", dic);
    
    
    
    return dic;
}

//异步请求block
- (void)asyncBlockClick:(id)sender
{
    NSLog(@"异步请求block\n");
    [_helper asynServiceMethodName:@"getForexRmbRate" success:^(ServiceResult *result) {
        BOOL boo=strlen([result.xmlString UTF8String])>0?YES:NO;
        if (boo) {
            
        }else{
            
        }
        NSArray *arr=[result.xmlParse soapXmlSelectNodes:@"//ForexRmbRate"];
        NSLog(@"解析xml结果=%@\n",arr);

    } failed:^(NSError *error, NSDictionary *userInfo) {
        NSLog(@"error=%@\n",[error description]);
        
    }];
}


@end
