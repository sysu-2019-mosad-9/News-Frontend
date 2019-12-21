//
//  NewsDetailModel.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailModel.h"

@implementation NewsDetailModel

- (instancetype)initWithDict:(NSDictionary *) dict{
    self = [super init];
    if (self){
        self.type = [dict objectForKey:@"type"];
        self.content = [dict objectForKey:@"content"];
    }
    return self;
}

@end
