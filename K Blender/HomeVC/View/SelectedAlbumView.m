//
//  SelectedAlbumView.m
//  K Blender
//
//  Created by YUAN on 2017/2/26.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import "SelectedAlbumView.h"
#import <Masonry.h>
#import "SelectedAlbumView.h"
#import "UI_Header.h"
#import "SelectedAlbumCell.h"


@interface SelectedAlbumView()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) void (^callBack)(PHAssetCollection *AssetCollection);

@end

@implementation SelectedAlbumView

- (instancetype)initWithFrame:(CGRect)frame  albumList:(NSArray <AblumList*>*)array reloadData:(void (^)(PHAssetCollection *AssetCollection))callBack;
{
    self = [super init];
    if (self) {
        self.callBack = callBack;
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:effectView];
        
        self.albumListArray = array;
        [self addTableView];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTableView];
    }
    return self;
}

- (void)reloadData{
    [self.tableView reloadData];
}
- (void)addTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.clipsToBounds = YES;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? CGFLOAT_MIN: 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.albumListArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    SelectedAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedAlbumCell"];
    if (!cell) {
        cell = [[SelectedAlbumCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SelectedAlbumCell"];
    }
    cell.model = self.albumListArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AblumList *model = self.albumListArray[indexPath.row];
    if (self.callBack) {
        self.callBack(model.assetCollection);
    }
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
