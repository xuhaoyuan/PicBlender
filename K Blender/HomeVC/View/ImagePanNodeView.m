//
//  ImagePanNodeView.m
//  K Blender
//
//  Created by YUAN on 2017/8/2.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import "ImagePanNodeView.h"
#import <Masonry.h>

@interface ImagePanNodeView()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *panView;

@end

@implementation ImagePanNodeView



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)panGes:(UIPanGestureRecognizer *)pan{
    if (self.pan) {
        self.pan(pan);
    }
}

- (void)setupSubviews{
    
    self.backgroundColor = [UIColor clearColor];
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:27/255.0 green:242/255.0 blue:252/255.0 alpha:1];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(2);
            make.centerY.mas_equalTo(0);
        }];
    }

    
    if (!_panView) {
        _panView = [[UIView alloc] init];
        _panView.backgroundColor = [UIColor colorWithRed:27/255.0 green:242/255.0 blue:252/255.0 alpha:1];
        _panView.layer.cornerRadius = 3;
        _panView.clipsToBounds = YES;
        [self addSubview:_panView];
        [_panView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.mas_width).multipliedBy(0.7);
            make.center.mas_equalTo(0);
            make.height.mas_equalTo(5);
        }];
    }

    
    
    
    
    
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [self addGestureRecognizer:ges];

}






@end
