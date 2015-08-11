//
//  LotuseedAgent.h
//  Lotuseed
//
//  Created by beyond on 15-5-22.
//  Copyright (c) 2012年 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>


@interface LotuseedAgent : CDVPlugin

// 初始化appkey
// command 中的值：
// eventId   : 自定义事件的 appkey
- (void)startWithAppKey:(CDVInvokedUrlCommand*)command;

// 触发自定义事件
// command 中的值：
// eventId   : 自定义事件的 eventId
- (void)onEvent:(CDVInvokedUrlCommand*)command;
    
// 触发自定义事件
// command 中的值：
// eventId:    自定义事件的 eventId
// eventLabel: 自定义事件的事件标签
- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command;

// 触发自定义事件
// command 中的值：
// eventId:    自定义事件的 eventId
// eventParams : 自定义事件的KV数据，Json 对象格式
- (void)onEventWithParams:(CDVInvokedUrlCommand*)command;

// 触发页面事件，在页面加载完毕的时候调用，记录页面名称和使用时长，一个页面调用这个接口后就不用再调用 onPageViewBegin 和 onPageViewEnd 接口了
// command 中的值：
// pageName  : 页面自定义名称
- (void)onPageView:(CDVInvokedUrlCommand*)command;

// 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageViewEnd 配合使用
// command 中的值：
// pageName  : 页面自定义名称
- (void)onPageViewBegin:(CDVInvokedUrlCommand*)command;

// 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageViewBegin 配合使用
// command 中的值：
// pageName  : 页面自定义名称
- (void)onPageViewEnd:(CDVInvokedUrlCommand*)command;

// 账号注册事件
// command 中的值：
// accountId  : 账号ID
- (void)onRegistration:(CDVInvokedUrlCommand*)command;

// 账号登录事件
// command 中的值：
// accountId  : 账号ID
- (void)onLogin:(CDVInvokedUrlCommand*)command;

// 账号登出事件
// command 中的值：
// accountId  : 账号ID
- (void)onLogout:(CDVInvokedUrlCommand*)command;

// 订单事件
// command 中的值：
// accountId  : 账号ID
// orderId    : 订单ID
// orderNum   : 订单数量
- (void)onOrder:(CDVInvokedUrlCommand*)command;


@end
