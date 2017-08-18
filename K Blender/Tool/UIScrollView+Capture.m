//
//  UIScrollView+Capture.m
//  BetweenTheLines
//
//  Created by YUAN on 2017/1/22.
//  Copyright © 2017年 ASOU. All rights reserved.
//

#import "UIScrollView+Capture.h"
#import "UIScrollView+YYAdd.h"
#import "UIView+YYAdd.h"

@implementation UIScrollView (Capture)


- (void)ContentVerticalScrollCapture:(UIView *)jionView :(void (^)(UIImage *capturedImage))completionHandler{
    //    UIView *snapShotView = [self snapshotViewAfterScreenUpdates:YES];
    //    [snapShotView setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, snapShotView.frame.size.width, snapShotView.frame.size.height)];
    //    [self.superview addSubview:snapShotView];
    
    CGPoint bakOffset = self.contentOffset;
    
    [self scrollToTop];
        
        int page  = floorf((CGFloat)(self.contentSize.height / self.bounds.size.height));
        
        CGSize scrollSize = self.contentSize;
        if (jionView) {
            scrollSize.height += jionView.height;
        }
        UIGraphicsBeginImageContextWithOptions(scrollSize, false, [UIScreen mainScreen].scale);
        
        if (self.frame.size.height < self.contentSize.height) {
            self.contentOffset = CGPointMake(0, self.contentSize.height - self.frame.size.height);
        }
        [self ContentScrollVerticalPageDraw:0 :(int)page :^{
            
            if (jionView) {
                [jionView drawViewHierarchyInRect:CGRectMake(0, self.contentSize.height, jionView.width, jionView.height) afterScreenUpdates:YES];
            }
            UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            NSData *jpgData = UIImageJPEGRepresentation(capturedImage, 1);
            UIImage *jpgImage = [UIImage imageWithData:jpgData];
            
            // Recover
            [self setContentOffset:bakOffset animated:NO];
            //                [snapShotView removeFromSuperview];
            completionHandler(jpgImage);
    }];
    
    
    NSLog(@"-- offset %f -- %f",self.contentOffset.y,self.self.contentSize.height);
    
    
    
}

- (void)ContentScrollVerticalPageDraw:(int)index :(int)maxIndex :(dispatch_block_t)drawCallback{
    int page  = floorf((CGFloat)(self.contentSize.height / self.bounds.size.height));
    if (page > maxIndex) {
        maxIndex = page;
    }
    [self setContentOffset:CGPointMake(0,  (CGFloat)(index) * self.frame.size.height) animated: NO];
    CGRect splitFrame = CGRectMake(0,  (CGFloat)(index) * self.frame.size.height, self.bounds.size.width, self.bounds.size.height);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self drawViewHierarchyInRect:splitFrame afterScreenUpdates:YES];
        if (index < maxIndex) {
            [self ContentScrollVerticalPageDraw:index + 1 :maxIndex :drawCallback];
            
            NSLog(@"正在截取——%d -- offset %f -- %f",index,self.contentOffset.y,self.self.contentSize.height);
        }else{
            drawCallback();
        }
    });
    
}







@end
