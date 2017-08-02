//
//  AssetScrollModel.m
//  K Blender
//
//  Created by YUAN on 2017/8/1.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import "AssetScrollModel.h"

@implementation AssetScrollModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scale = 0;
    }
    return self;
}

- (CGFloat)scale{
    if (_scale == 0) {
        return (float)self.asset.pixelWidth / (float)self.asset.pixelHeight;
    }else{
        return _scale;
    }
}

@end
