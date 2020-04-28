//
//  NSObject+Timer.m
//  NoticeSheet
//
//  Created by libx on 2019/8/5.
//  Copyright © 2019 LF. All rights reserved.
//

#import "NSObject+Timer.h"

@implementation NSObject (Timer)

- (void)dispatchTimer:(id)observer timeInterval:(NSTimeInterval)timeInterval handle:(void(^)(dispatch_source_t timer))handle {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    __weak typeof(observer)weakObserver = observer;
    dispatch_source_set_event_handler(timer, ^{
        if (!weakObserver) {
            dispatch_source_cancel(timer);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                handle(timer);
            });
        }
    });
    dispatch_resume(timer);
}

- (void)addTimer:(id)observer timeInterval:(NSTimeInterval)timeInterval selector:(SEL)selector {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    __weak typeof(observer)weakObserver = observer;
    __weak typeof(self)weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        if (!weakObserver) {
            dispatch_source_cancel(timer);
        } else {
            if ([weakSelf respondsToSelector:selector]) {
                [weakSelf performSelectorOnMainThread:selector withObject:timer waitUntilDone:YES];
            }
        }
    });
    dispatch_resume(timer);
}

@end
