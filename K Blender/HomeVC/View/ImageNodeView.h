//
//  ImageNodeView.h
//  K Blender
//
//  Created by YUAN on 2017/8/1.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetScrollModel.h"
#import "ViewController.h"
#import "ImagePanNodeView.h"

@interface ImageNodeView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) AssetScrollModel *assetModel;

@property (nonatomic, assign) CGRect currentRect;

@property (nonatomic, weak) ViewController *superVC;

@property (nonatomic, weak) ImageNodeView *beforeNodeView;
@property (nonatomic, weak) ImageNodeView *afterNodeView;

@property (nonatomic, assign) BOOL beforeSelected;
@property (nonatomic, assign) BOOL afterSelected;


@property (nonatomic, assign) BOOL alphaState;


- (void)bottomPan:(UIPanGestureRecognizer *)ges;


@end
