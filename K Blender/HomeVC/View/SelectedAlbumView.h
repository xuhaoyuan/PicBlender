//
//  SelectedAlbumView.h
//  K Blender
//
//  Created by YUAN on 2017/2/26.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AblumTool.h"

@interface SelectedAlbumView : UIView


@property (nonatomic, strong) NSArray <AblumList*>*albumListArray;

- (instancetype)initWithFrame:(CGRect)frame
                    albumList:(NSArray <AblumList*>*)array
                   reloadData:(void (^)(PHAssetCollection *AssetCollection))callBack;

- (void)reloadData;
@end
