//
//  ViewController.h
//  K Blender
//
//  Created by YUAN on 2017/2/25.
//  Copyright © 2017年 YUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController



- (void) willbeginUpdateScrollListLayout;


- (void) updateScrollListLayoutPanTop:(CGFloat)offsety;

- (void) updateScrollListLayoutPanBottom;

- (void) didEndUpdateScrollListLayout;

- (void) updateScrollViewContentOffset;

@end

