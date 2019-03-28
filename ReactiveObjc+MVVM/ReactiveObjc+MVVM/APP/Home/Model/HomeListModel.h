//
//  HomeListModel.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UserInfo;

@interface HomeListModel : NSObject

@property (strong, nonatomic) NSString *weiboId;
@property (strong, nonatomic) NSString *text;
@property (nonatomic,strong) UserInfo *user;

@end

@interface UserInfo : NSObject

@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSURL *profile_image_url;
@property (nonatomic,copy) NSString *location;

@end

NS_ASSUME_NONNULL_END
