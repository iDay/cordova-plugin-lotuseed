//
//  LotuseedAgent.m
//  Lotuseed
//
//  Created by beyond on 15-5-22.
//  Copyright (c) 2012 beyond. All rights reserved.
//

#import "LotuseedAgent.h"
#import "Lotuseed.h"

@interface LotuseedAgent ()

#if __has_feature(objc_arc)
@property (nonatomic, strong) NSString *currPageName;
#else
@property (nonatomic, retain) NSString *currPageName;
#endif

@end

@implementation LotuseedAgent

#if __has_feature(objc_arc)
#else
- (void)dealloc {
    [super dealloc];
    [self.currPageName release];
}
#endif

- (NSDictionary *)jsonToDictionary:(NSString *)jsonStr {
    if (jsonStr) {
        NSError* error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if (error == nil && [object isKindOfClass:[NSDictionary class]]) {
            return object;
        }
    }
    
    return nil;
}

- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if ([eventLabel isKindOfClass:[NSNull class]]) {
        eventLabel = nil;
    }
    [Lotuseed onEvent:eventId label:eventLabel];
}

- (void)onEventWithParams:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSDictionary *parameters = nil;
    NSString *parametersJson = [command.arguments objectAtIndex:1];
    if (![parametersJson isKindOfClass:[NSNull class]]) {
        parameters = [self jsonToDictionary:parametersJson];
    }
    [Lotuseed onEvent:eventId attributes:parameters];
}

- (void)onPageView:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if (self.currPageName) {
        [Lotuseed onPageViewEnd:self.currPageName];
    }
    self.currPageName = pageName;
    [Lotuseed onPageViewBegin:self.currPageName];
}

- (void)onPageViewBegin:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    self.currPageName = pageName;
    [Lotuseed onPageViewBegin:self.currPageName];
}

- (void)onPageViewEnd:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    [Lotuseed onPageViewEnd:pageName];
    self.currPageName = nil;
}

- (void)onRegistration:(CDVInvokedUrlCommand*)command {
	NSString *accountId = [command.arguments objectAtIndex:0];
    if (accountId == nil || [accountId isKindOfClass:[NSNull class]]) {
        return;
    }
    [Lotuseed onRegistration:accountId];
}

- (void)onLogin:(CDVInvokedUrlCommand*)command {
	NSString *accountId = [command.arguments objectAtIndex:0];
    if (accountId == nil || [accountId isKindOfClass:[NSNull class]]) {
        return;
    }
    [Lotuseed onLogin:accountId];
}

- (void)onLogout:(CDVInvokedUrlCommand*)command {
	NSString *accountId = [command.arguments objectAtIndex:0];
    if (accountId == nil || [accountId isKindOfClass:[NSNull class]]) {
        return;
    }
    [Lotuseed onLogout:accountId];
}

- (void)onOrder:(CDVInvokedUrlCommand*)command {
	NSString *accountId = [command.arguments objectAtIndex:0];
    if (accountId == nil || [accountId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *order = [command.arguments objectAtIndex:1];
    if (order == nil || [order isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *number = [command.arguments objectAtIndex:2];
    if (number == nil || [number isKindOfClass:[NSNull class]]) {
        return;
    }
    [Lotuseed onOrder:accountId orderId:order amount:[number doubleValue]];
}

@end
