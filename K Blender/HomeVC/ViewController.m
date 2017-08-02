//
//  ViewController.m
//  K Blender
//
//  Created by YUAN on 2017/2/25.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import "ViewController.h"
#import "AblumTool.h"
#import "PicCollectionViewCell.h"
#import "UI_Header.h"
#import "SelectedAlbumView.h"
#import <Masonry.h>
#import "AssetScrollModel.h"
#import "ImageNodeView.h"
#import "UIScrollView+YYAdd.h"
#import "ImagePanNodeView.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *topSelectedView;
@property (strong, nonatomic) UICollectionView *photoCollectionView;
@property (strong, nonatomic) UICollectionView *nearlyCollectionView;

@property(nonatomic, strong)NSMutableArray <PHAsset *>*dataArr;

@property (nonatomic, strong) NSMutableArray <PHAsset *>*nearlyListArray;
@property (nonatomic, strong) PHAssetCollection *nearlyAssetCollection;

@property (weak, nonatomic) IBOutlet UIView *bottomToolBar;

@property (nonatomic, strong) NSMutableArray <AblumList *>*albumListArray;

@property (nonatomic, strong) SelectedAlbumView *albumView;

@property (nonatomic, assign) UIEdgeInsets showAreaInsets;
@property (weak, nonatomic) IBOutlet UIButton *allAlbumBtn;
@property (weak, nonatomic) IBOutlet UIButton *recentlyBtn;
@property (assign, nonatomic) BOOL selectedAlumViewShow;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *tapControl;
@property (weak, nonatomic) IBOutlet UIView *panHoldControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedViewHeight;

@property (nonatomic, assign) CGRect panRect;
@property (nonatomic, assign) UIRectEdge rectEdge;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;

@property (nonatomic, strong) NSMutableArray <ImageNodeView *>*ScrollArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rectEdge = UIRectEdgeNone;
    
    [self.scrollView addSubview:self.photoCollectionView];
    [self.scrollView addSubview:self.nearlyCollectionView];
    
    self.scrollView.contentSize = CGSizeMake(W_SCREEN * 2, H_SCREEN);
    self.scrollView.pagingEnabled = YES;
    
    self.contentScroll.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
    
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    
    self.tapControl.layer.cornerRadius = self.tapControl.frame.size.height/2;
    self.panHoldControl.userInteractionEnabled = YES;
    [self.panHoldControl addGestureRecognizer:ges];
    
    
    self.selectedAlumViewShow = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self reloadAllAlbumList];
    
    
    self.showAreaInsets = UIEdgeInsetsMake(self.topSelectedView.frame.size.height, 1, self.bottomToolBar.frame.size.height, 1);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAllAlbumList) name:@"applicationDidBecomeActive" object:nil];
    [self addAlbumListView];
    
}
- (void)reloadAllAlbumList{
    [self.albumListArray addObjectsFromArray:[[AblumTool sharePhotoTool] getPhotoAblumList]];
    
    
    [self.dataArr addObjectsFromArray:[[AblumTool sharePhotoTool] getAllAssetInPhotoAblumWithAscending:YES]];
    [self.photoCollectionView reloadData];
    
    
    [self.albumListArray enumerateObjectsUsingBlock:^(AblumList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.title isEqualToString:@"最近添加"]) {
            self.nearlyAssetCollection = obj.assetCollection;
        }
    }];
    
    [self.nearlyListArray addObjectsFromArray:[[AblumTool sharePhotoTool] getAssetsInAssetCollection:self.nearlyAssetCollection ascending:YES]];
    [self.nearlyCollectionView reloadData];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _nearlyCollectionView) {
        return _nearlyListArray.count;
    }else if(collectionView == _photoCollectionView){
        return _dataArr.count;
    }else{
        return 0;
    }
}
//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.nearlyCollectionView) {
        PicCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"_nearlyCollectionView" forIndexPath:indexPath];
        cell.collectionView = self.nearlyCollectionView;
        PHAsset *asset = _nearlyListArray[indexPath.row];
        cell.asset = asset;
        return cell;
        
        
    }else if (collectionView == self.photoCollectionView){
        PicCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"_photoCollectionView" forIndexPath:indexPath];
        cell.collectionView = self.photoCollectionView;
        PHAsset *asset = _dataArr[indexPath.row];
        cell.asset = asset;
        return cell;
        
    }
    return nil;
}

- (void)panGes:(UIPanGestureRecognizer *)pan{
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self.view bringSubviewToFront:self.topSelectedView];
        CGPoint orgin = [pan locationInView:self.view];
        CGSize size = self.topSelectedView.frame.size;
        self.panRect = CGRectMake(orgin.x, orgin.y, size.width, size.height);
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        CGPoint point = [pan locationInView:self.view];
        
        CGFloat height = self.panRect.size.height + point.y - self.panRect.origin.y;
        if (self.selectedViewHeight.constant > height) {
            self.rectEdge = UIRectEdgeTop;
        }else if(self.selectedViewHeight.constant <= height){
            self.rectEdge = UIRectEdgeBottom;
        }
        if (height < 200) {
            height = 200;
        }else if (height > H_SCREEN){
            height = H_SCREEN;
        }
        self.selectedViewHeight.constant = height;
    }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled){
        
        if (self.rectEdge == UIRectEdgeTop) {
            self.selectedViewHeight.constant = 200;
        }else if(self.rectEdge == UIRectEdgeBottom){
            self.selectedViewHeight.constant = H_SCREEN;
        }
        
        //        if (self.selectedViewHeight.constant > (200 + H_SCREEN)/2) {
        //            self.selectedViewHeight.constant = H_SCREEN;
        //        }else{
        //            self.selectedViewHeight.constant = 200;
        //        }
        
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.8
                            options:UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
                                [self.view layoutIfNeeded];
                            } completion:^(BOOL finished) {
                                
                            }];
        
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((W_DEVICE - 2 * 3 - 2)/4, (W_DEVICE - 2 * 3 - 2)/4);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _nearlyCollectionView) {
        
    }else{
        PHAsset *asset = _dataArr[indexPath.row];
        [self addNewImage:asset];
    }
}

- (void)addNewImage:(PHAsset *)asset{
    __block  BOOL alreadyHave = NO;
    [self.ScrollArray enumerateObjectsUsingBlock:^(ImageNodeView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.assetModel.asset.localIdentifier isEqualToString:asset.localIdentifier]) {
            alreadyHave = YES;
        }
    }];
    if (!alreadyHave) {
        AssetScrollModel *model = [[AssetScrollModel alloc] init];
        model.asset = asset;
        ImageNodeView *nodeView = [[ImageNodeView alloc] init];
        nodeView.assetModel = model;
        [self.ScrollArray addObject:nodeView];
        [self renderToScrollView];
    }
}


- (void)renderToScrollView{
    __block float maxOriginY = 0;
    __block ImageNodeView *beforeNodeView = nil;
    
    CGSize size = self.contentScroll.frame.size;
    
    [self.ScrollArray enumerateObjectsUsingBlock:^(ImageNodeView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ImageNodeView *nodeView = obj;
        if (obj) {
            nodeView.beforeNodeView = beforeNodeView;
            beforeNodeView.afterNodeView = nodeView;
        }
        nodeView.superVC = self;
        if (CGRectEqualToRect(nodeView.currentRect, CGRectZero)) {
            CGRect rect = CGRectMake(0, maxOriginY, size.width,100);
            nodeView.frame = rect;
            nodeView.currentRect = rect;
        }
        if (!nodeView.superview) {
            [self.contentScroll addSubview:nodeView];
        }
        beforeNodeView = obj;
        maxOriginY = CGRectGetMaxY(nodeView.frame);
    }];
    self.contentScroll.contentSize = CGSizeMake(size.width, maxOriginY);
    [self.contentScroll scrollToBottomAnimated:YES];
}


- (void)updateSubNodeLayout{
    __block float maxOriginY = 0;
    [self.ScrollArray enumerateObjectsUsingBlock:^(ImageNodeView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ImageNodeView *nodeView = obj;
        nodeView.superVC = self;
        if (obj.currentRect.origin.y != maxOriginY) {
            obj.currentRect = CGRectMake(0, maxOriginY, obj.currentRect.size.width, obj.currentRect.size.height);
            obj.frame = obj.currentRect;
        }
        maxOriginY = CGRectGetMaxY(nodeView.frame);
    }];
    self.contentScroll.contentSize = CGSizeMake(0, maxOriginY);
}


- (void)addAlbumListView{
    
    CGRect showRect = UIEdgeInsetsInsetRect(self.view.frame, _showAreaInsets);
    self.albumView = [[SelectedAlbumView alloc] initWithFrame:CGRectMake(0, H_SCREEN, showRect.size.width, showRect.size.height) albumList:self.albumListArray reloadData:^(PHAssetCollection *AssetCollection) {
        
        NSArray<PHAsset *> *reloadAssets = [[AblumTool sharePhotoTool] getAssetsInAssetCollection:AssetCollection ascending:YES];
        
        //        [self.photoCollectionView performBatchUpdates:^{
        
        if (ArrIsNotEmpty(self.dataArr)) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:reloadAssets];
        self.allAlbumBtn.titleLabel.text = AssetCollection.localizedTitle;
        [self.photoCollectionView reloadData];
        //        } completion:^(BOOL finished) {
        [self setSelectedAlumViewShow:NO];
        //        }];
        
    }];
    [self.view addSubview:self.albumView];
    [self.albumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(showRect.size.height);
        make.bottom.mas_equalTo(showRect.size.height);
    }];
    
    
    //    [self.view setNeedsLayout];
}
- (IBAction)allAlbumBtnClick:(id)sender {
    if (self.scrollView.contentOffset.x != 0) {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }else{
        self.selectedAlumViewShow = !_selectedAlumViewShow;
    }
}
- (IBAction)recentlyBtnClick:(id)sender {
    if (self.selectedAlumViewShow) {
        self.selectedAlumViewShow = NO;
    }
    [self.scrollView scrollRectToVisible:self.nearlyCollectionView.frame animated:NO];
}

- (void)setSelectedAlumViewShow:(BOOL)selectedAlumViewShow{
    _selectedAlumViewShow = selectedAlumViewShow;
    [self.view bringSubviewToFront:self.albumView];
    [self.view bringSubviewToFront:self.bottomToolBar];
    if (_selectedAlumViewShow) {
        [self.albumView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(- _showAreaInsets.bottom);
        }];
    }else{
        
        [self.albumView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.albumView.frame.size.height);
        }];
    }
    [self.albumView reloadData];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.8
                        options:UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
                            [self.view layoutIfNeeded];
                            
                        } completion:^(BOOL finished) {
                            
                        }];
}
- (void)setShowAreaInsets:(UIEdgeInsets)showAreaInsets{
    _showAreaInsets = showAreaInsets;
    self.photoCollectionView.contentInset = _showAreaInsets;
    self.photoCollectionView.scrollIndicatorInsets = _showAreaInsets;
    
    self.nearlyCollectionView.contentInset = _showAreaInsets;
    self.nearlyCollectionView.scrollIndicatorInsets = _showAreaInsets;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray<AblumList *> *)albumListArray{
    if (!_albumListArray) {
        _albumListArray = [NSMutableArray new];
    }
    return _albumListArray;
}

- (NSMutableArray<PHAsset *> *)nearlyListArray{
    if (!_nearlyListArray) {
        _nearlyListArray = [NSMutableArray new];
    }
    return _nearlyListArray;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (UICollectionView *)nearlyCollectionView{
    if (!_nearlyCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _nearlyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(W_SCREEN, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
        _nearlyCollectionView.delegate = self;
        _nearlyCollectionView.dataSource = self;
        [_nearlyCollectionView registerClass:[PicCollectionViewCell class] forCellWithReuseIdentifier:@"_nearlyCollectionView"];
        _nearlyCollectionView.alwaysBounceVertical = YES;
        _nearlyCollectionView.bounces = YES;
        //        _nearlyCollectionView.allowsMultipleSelection = YES;
    }
    return _nearlyCollectionView;
}
- (UICollectionView *)photoCollectionView{
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
        [_photoCollectionView registerClass:[PicCollectionViewCell class] forCellWithReuseIdentifier:@"_photoCollectionView"];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.alwaysBounceVertical = YES;
        _photoCollectionView.bounces = YES;
        //        _photoCollectionView.allowsMultipleSelection = YES;
    }
    return _photoCollectionView;
}

- (NSMutableArray<ImageNodeView *> *)ScrollArray{
    if (!_ScrollArray) {
        _ScrollArray = [NSMutableArray new];
    }
    return _ScrollArray;
}

@end
