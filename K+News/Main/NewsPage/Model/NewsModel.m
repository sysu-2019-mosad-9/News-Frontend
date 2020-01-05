//
//  NewsModel.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self){
        self.ID = [dict objectForKey:@"id"];
        self.title = [dict objectForKey:@"title"];
        self.imageLinks = [dict objectForKey:@"image_links"];
        self.detailUrl = [dict objectForKey:@"detail_url"];
    }
    return self;
}

@end
