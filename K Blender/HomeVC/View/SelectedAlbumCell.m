//
//  SelectedAlbumCell.m
//  K Blender
//
//  Created by XU on 2017/8/1.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import "SelectedAlbumCell.h"

@implementation SelectedAlbumCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AblumList *)model{
    _model = model;
    
    self.textLabel.text = model.title;
    self.textLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.text = [NSString stringWithFormat:@"%ld",model.count];
    [[AblumTool sharePhotoTool] requestImageForAsset:model.headImageAsset
                                                size:CGSizeMake(self.contentView.frame.size.height, self.contentView.frame.size.height)
                                          resizeMode:PHImageRequestOptionsResizeModeFast
                                          completion:^(UIImage *image) {
                                              self.imageView.image = image;
                                              self.imageView.clipsToBounds = YES;
                                          }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
