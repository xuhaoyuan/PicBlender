//
//  PicCollectionViewCell.h
//  K Blender
//
//  Created by YUAN on 2017/2/25.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PicCollectionViewCell : UICollectionViewCell



@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, weak) UICollectionView *collectionView;
@end
