//
//  BasicViewController.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-23.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimateLoadView.h"
#import "AnimateErrorView.h"
@interface BasicViewController : UIViewController<UIAlertViewDelegate>
{
    UITableView *middleView;
    int middleFlag;//标志中间的弹出框是否存在
    UITableView *rightView;
    int rightFlag;//标志右边的弹出框是否存在
    NSMutableArray *_array;
    int flag;//标志是否有弹出框存在
}

@property (nonatomic, retain) UIAlertView *alertView;

@property (nonatomic, retain) UIActivityIndicatorView *activityView;

//动画操作
-(AnimateErrorView*) errorView;
-(AnimateErrorView*) successView;
-(AnimateLoadView*) loadingView;
-(void) showLoadingAnimatedWithTitle:(NSString*)title;
-(void) showLoadingAnimated:(void (^)(AnimateLoadView *loadView))process;
-(void) hideLoadingViewAnimated:(void (^)(AnimateLoadView *hideView))complete;
-(void) hideLoadingSuccessWithTitle:(NSString*)title completed:(void (^)(AnimateErrorView *successView))complete;
-(void) hideLoadingFailedWithTitle:(NSString*)title completed:(void (^)(AnimateErrorView *failedView))complete;

-(void) showErrorViewAnimated:(void (^)(AnimateErrorView *errorView))process;
-(void) hideErrorViewAnimatedWithDuration:(NSTimeInterval)duration completed:(void (^)(AnimateErrorView *errorView))complete;
-(void) hideErrorViewAnimated:(void (^)(AnimateErrorView *errorView))complete;
-(void) showErrorViewWithHide:(void (^)(AnimateErrorView *errorView))process completed:(void (^)(AnimateErrorView *errorView))complete;


-(void) showSuccessViewAnimated:(void (^)(AnimateErrorView *successView))process;
-(void) hideSuccessViewAnimated:(void (^)(AnimateErrorView *successView))complete;
-(void) showSuccessViewWithHide:(void (^)(AnimateErrorView *successView))process completed:(void (^)(AnimateErrorView *successView))complete;


@end
