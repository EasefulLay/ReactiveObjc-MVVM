//
//  HomeListTableViewCell.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "HomeListTableViewCell.h"
#import "HomeListModel.h"

@interface HomeListTableViewCell ()

@property (strong, nonatomic)  UILabel *userName;
@property (strong, nonatomic)  UILabel *userLocation;
@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *weiboText;


@end


@implementation HomeListTableViewCell

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
    }
    return _headImageView;
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
    }
    return _userName;
}

- (UILabel *)userLocation {
    if (!_userLocation) {
        _userLocation = [[UILabel alloc] init];
    }
    return _userLocation;
}

- (UILabel *)weiboText {
    if (!_weiboText) {
        _weiboText = [[UILabel alloc] init];
        _weiboText.numberOfLines = 0;
    }
    return _weiboText;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setupViews {
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.userLocation];
    [self.contentView addSubview:self.weiboText];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    
    CGFloat paddingEdge = 10;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(paddingEdge);
        make.top.mas_equalTo(paddingEdge);
        make.size.mas_equalTo(CGSizeMake(80, 80)).priorityHigh();
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(paddingEdge);
        make.top.equalTo(self.headImageView);
        make.right.mas_equalTo(-paddingEdge);
        make.height.mas_equalTo(2*paddingEdge).priorityHigh();
    }];
    
    [self.userLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName);
        make.top.equalTo(self.userName.mas_bottom).offset(paddingEdge);
        make.right.mas_equalTo(-paddingEdge);
        make.bottom.equalTo(self.headImageView);
    }];
    
    [self.weiboText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(paddingEdge);
        make.left.equalTo(self.headImageView);
        make.right.mas_equalTo(-paddingEdge);
        make.bottom.mas_equalTo(-paddingEdge);
    }];
    
    [super updateConstraints];
}


-(void)bindViewModel {
    
    
}

-(void)setHomeListModel:(HomeListModel *)homeListModel {
    if (!homeListModel) {
        return;
    }
    _homeListModel = homeListModel;
    self.userName.text = _homeListModel.user.name;
    self.userLocation.text = _homeListModel.user.location;
    self.weiboText.text = _homeListModel.text;
    [self.headImageView setImageWithURL:_homeListModel.user.profile_image_url];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
