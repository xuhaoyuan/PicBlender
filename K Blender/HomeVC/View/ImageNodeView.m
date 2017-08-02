//
//  ImageNodeView.m
//  K Blender
//
//  Created by YUAN on 2017/8/1.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import "ImageNodeView.h"
#import <Masonry.h>
#import "AblumTool.h"

@interface ImageNodeView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL selected;


@property (nonatomic, assign) CGRect beginRect;

@property (nonatomic, strong) ImagePanNodeView *beforePanView;
@property (nonatomic, strong) ImagePanNodeView *afterPanView;

@end

@implementation ImageNodeView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selected = NO;
        self.currentRect = CGRectZero;
        self.clipsToBounds = YES;
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.delegate = self;
        self.scrollView.bouncesZoom = YES;
        self.scrollView.maximumZoomScale = 3;
        self.scrollView.multipleTouchEnabled = YES;
        self.scrollView.alwaysBounceVertical = NO;
        self.scrollView.showsVerticalScrollIndicator = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.scrollEnabled = NO;
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [self.scrollView addSubview:self.imageView];
        
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
        [self.scrollView addGestureRecognizer:tapges];
        
    }
    return self;
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    self.imageView.frame = CGRectMake(0,
                                      0,
                                      self.bounds.size.width,
                                      self.bounds.size.width / _assetModel.scale);
    self.scrollView.contentSize = self.imageView.frame.size;
    CGRect scrollRect = CGRectMake(0,
                                   (self.imageView.frame.size.height - self.frame.size.height)/2,
                                   self.bounds.size.width,
                                   self.bounds.size.height);
    [self.scrollView scrollRectToVisible:scrollRect animated:NO];
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeNone;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;//控制照片质量
    option.networkAccessAllowed = YES;
    //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:_assetModel.asset
                                                      targetSize:self.imageView.frame.size
                                                     contentMode:PHImageContentModeAspectFit
                                                         options:option
                                                   resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
                                                       self.imageView.image = image;

                                                   }];
    [self.superview addSubview:self.beforePanView];
    [self.beforePanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.mas_top);
    }];
    [self.superview addSubview:self.afterPanView];
    [self.afterPanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.mas_bottom);
    }];
    [self.superview layoutIfNeeded];
    
}


- (void)tapGes:(UITapGestureRecognizer *)ges{
    if (self.beforeNodeView) {
        [self.beforeNodeView setBeforeSelected:NO];
    }
    if (self.afterNodeView) {
        [self.afterNodeView setAfterSelected:NO];
    }
    self.selected = !self.selected;

}
- (void)bottomPan:(UIPanGestureRecognizer *)ges{
    if (ges.state == UIGestureRecognizerStateBegan) {
        CGPoint point2 = [ges locationInView:self.superview];
        _beginRect.origin = point2;
        _beginRect.size = self.frame.size;
    }else if (ges.state == UIGestureRecognizerStateChanged){
        CGPoint point = [ges locationInView:self.superview];
        CGRect frame = self.frame;
        frame.size.height = point.y - _beginRect.origin.y + _beginRect.size.height;
        if (frame.size.width/frame.size.height <= self.assetModel.scale) {
            frame.size.height = self.frame.size.width/self.assetModel.scale;
        }
        self.frame = frame;
        self.currentRect = frame;
        [_superVC updateSubNodeLayout];
    }else if (ges.state == UIGestureRecognizerStateEnded){
        
    }else if (ges.state == UIGestureRecognizerStateCancelled){
        
    }else if (ges.state == UIGestureRecognizerStateFailed){
        
    }
}
- (void)topPan:(UIPanGestureRecognizer *)ges{
    if (self.beforeNodeView) {
        [self.beforeNodeView bottomPan:ges];
    }
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;

    
    if (_selected) {
        
        self.scrollView.scrollEnabled = YES;
        self.beforePanView.hidden = NO;
        self.afterPanView.hidden = NO;
        [self.superview bringSubviewToFront:self.beforePanView];
        [self.superview bringSubviewToFront:self.afterPanView];
        [UIView animateWithDuration:0.3 animations:^{
            self.beforePanView.alpha = 1;
            self.afterPanView.alpha = 1;
        }];
    }else{
        self.scrollView.scrollEnabled = NO;
      
        [UIView animateWithDuration:0.3 animations:^{
            self.beforePanView.alpha = 0;
            self.afterPanView.alpha = 0;
        }completion:^(BOOL finished) {
            self.beforePanView.hidden = YES;
            self.afterPanView.hidden = YES;
        }];

    }
    
}
- (void)setBeforeSelected:(BOOL)beforeSelected{
    _beforeSelected = beforeSelected;
    [self setSelected:_beforeSelected];
    if (self.beforeNodeView) {
        [self.beforeNodeView setBeforeSelected:_beforeSelected];
    }
}

- (void)setAfterSelected:(BOOL)afterSelected{
    _afterSelected = afterSelected;
    [self setSelected:_afterSelected];
    if (self.afterNodeView) {
        [self.afterNodeView setAfterSelected:_afterSelected];
    }
}


- (void)setAssetModel:(AssetScrollModel *)assetModel{
    _assetModel = assetModel;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    UIView *subView = self.imageView;
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (ImagePanNodeView *)beforePanView{
    if (!_beforePanView) {
        _beforePanView = [[ImagePanNodeView alloc] init];
        _beforePanView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _beforePanView.pan = ^(UIPanGestureRecognizer *ges) {
            [weakSelf topPan:ges];
        };
    }
    return _beforePanView;
}
- (ImagePanNodeView *)afterPanView{
    if (!_afterPanView) {
        _afterPanView = [[ImagePanNodeView alloc] init];
        _afterPanView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _afterPanView.pan = ^(UIPanGestureRecognizer *ges) {
            [weakSelf bottomPan:ges];
        };
    }
    return _afterPanView;
}
@end
