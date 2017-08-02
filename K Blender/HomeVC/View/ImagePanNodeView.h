//
//  ImagePanNodeView.h
//  K Blender
//
//  Created by YUAN on 2017/8/2.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePanNodeView : UIView

@property (nonatomic, copy) void (^pan)(UIPanGestureRecognizer *ges);

@end
