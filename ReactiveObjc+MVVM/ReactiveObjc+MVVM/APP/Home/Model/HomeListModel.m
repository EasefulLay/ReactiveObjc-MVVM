//
//  HomeListModel.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "HomeListModel.h"

@implementation HomeListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"weiboId" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"user" : [UserInfo class]};
}


@end

@implementation UserInfo

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"userId" : @"id"};
}

@end

