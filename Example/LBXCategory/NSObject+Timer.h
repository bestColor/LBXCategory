//
//  NSObject+Timer.h
//  NoticeSheet
//
//  Created by libx on 2019/8/5.
//  Copyright © 2019 LF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Timer)

/**
    启动定时器，避免重复引用的问题
 
    @param  observer            跟定时器绑定的观察的对象（观察的对象销毁的时候,定时器也销毁）
    @param  timeInterval        每次事件的间隔（秒）
    @param  handle              创建的定时器的回调（dispatch_source_t timer）
 */
- (void)dispatchTimer:(id)observer timeInterval:(NSTimeInterval)timeInterval handle:(void(^)(dispatch_source_t timer))handle;

/**
    启动定时器，避免重复引用的问题
 
    @param  observer          跟定时器绑定的观察的对象（观察的对象销毁的时候,定时器也销毁）
    @param  timeInterval      每次事件的间隔（秒）
    @param  selector          定时器定时执行的方法
 */
- (void)addTimer:(id)observer timeInterval:(NSTimeInterval)timeInterval selector:(SEL)selector ;


@end

NS_ASSUME_NONNULL_END
