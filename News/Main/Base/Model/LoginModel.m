//
//  LoginModel.m
//  News
//
//  Created by tplish on 2019/12/20.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface LoginModel()

@end

@implementation LoginModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self){
        self.token = [dict objectForKey:@"token"];
//        self.avatar = [dict objectForKey:@"avatar"];
        self.success = [dict objectForKey:@"success"];
    }
    return self;
}

@end
