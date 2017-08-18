//
//  UIScrollView+Capture.h
//  BetweenTheLines
//
//  Created by YUAN on 2017/1/22.
//  Copyright © 2017年 ASOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Capture)

- (void)ContentVerticalScrollCapture:(UIView *)jionView :(void (^)(UIImage *capturedImage))completionHandler;


@end
