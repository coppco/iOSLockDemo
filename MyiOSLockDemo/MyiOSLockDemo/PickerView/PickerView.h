//
//  PickerView.h
//  MyiOSLockDemo
//
//  Created by M-coppco on 15/12/3.
//  Copyright © 2015年 M-coppco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIView

@property (nonatomic, copy) void (^sureButtonBlock)();
@property (nonatomic, copy) void (^cancelButtonBlock)();
- (NSString *)getCurrentTitle;
@end
