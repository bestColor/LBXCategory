//
//  UITableView+Animation.m
//  NoticeSheet
//
//  Created by libx on 2019/8/6.
//  Copyright © 2019 LF. All rights reserved.
//

#import "UITableView+Animation.h"

@implementation UITableView (Animation)

- (void)reloadDataAnimation {
    [UIView transitionWithView:self duration:0.33 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self reloadData];
    } completion:^(BOOL finished) {
        
    }];
}

@end
