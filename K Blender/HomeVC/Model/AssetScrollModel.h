//
//  AssetScrollModel.h
//  K Blender
//
//  Created by YUAN on 2017/8/1.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface AssetScrollModel : NSObject


@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) CGFloat scale;

@end
