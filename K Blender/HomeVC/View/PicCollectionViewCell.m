//
//  PicCollectionViewCell.m
//  K Blender
//
//  Created by YUAN on 2017/2/25.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import "PicCollectionViewCell.h"


@interface PicCollectionViewCell()


@property (nonatomic, assign) PHImageRequestID ImageRequestID;

@end


@implementation PicCollectionViewCell


- (void)awakeFromNib{
    [super awakeFromNib];
    [self.contentView addSubview:self.headerImageView];
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.headerImageView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.headerImageView];
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)prepareForReuse{
    [super prepareForReuse];
    if (!isnan(self.ImageRequestID)) {
        [[PHCachingImageManager defaultManager]cancelImageRequest:self.ImageRequestID];
    }
    self.headerImageView.image = nil;
}
- (void)setAsset:(PHAsset *)asset{
    _asset = asset;
    
    CGSize size = [self getSizeWithAsset:asset];
    [self requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeNone];
    
}
- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode{
    /**
     resizeMode：对请求的图像怎样缩放。有三种选择：None，默认加载方式；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
     deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
     这个属性只有在 synchronous 为 true 时有效。
     */
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    option.synchronous = NO;
    option.resizeMode = resizeMode;//控制照片尺寸
    //option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;//控制照片质量
    
    //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    option.networkAccessAllowed = YES;
    self.ImageRequestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset
                                                                            targetSize:size
                                                                           contentMode:PHImageContentModeAspectFit
                                                                               options:option
                                                                         resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
                                                                             if ([[info objectForKey:PHImageResultRequestIDKey] intValue] == self.ImageRequestID) {
                                                                                 self.headerImageView.image = image;
                                                                             }
                                                                         }];
    
}
- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _headerImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _headerImageView;
}

- (CGSize)getSizeWithAsset:(PHAsset *)asset
{
    CGFloat width  = (CGFloat)asset.pixelWidth;
    CGFloat height = (CGFloat)asset.pixelHeight;
    CGFloat scale = width/height;
    
    return CGSizeMake(self.contentView.frame.size.width*scale, self.contentView.frame.size.width);
}

@end
