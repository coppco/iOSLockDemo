//
//  PickerView.m
//  MyiOSLockDemo
//
//  Created by M-coppco on 15/12/3.
//  Copyright © 2015年 M-coppco. All rights reserved.
//

#import "PickerView.h"

@interface PickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong)UIButton *sureButton;
@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)UIPickerView *pickerView;
@property (nonatomic, copy)NSString *string;
@end

@implementation PickerView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = @[@"立即", @"30秒", @"1分钟", @"3分钟", @"5分钟", @"10分钟"];
        self.sureButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        self.sureButton.frame = CGRectMake(0, 0, 60, 40);
        [self.sureButton setTitle:@"确定" forState:(UIControlStateNormal)];
        self.sureButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:1];
        [self.sureButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        
        self.cancelButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        self.cancelButton.frame = CGRectMake(kVWidth - 60, 0, 60, 40);
        [self.cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:1];
        [self.cancelButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.sureButton];
        [self addSubview:self.cancelButton];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kVWidth, kVHeight - 40)];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self addSubview:self.pickerView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)cancelAction:(UIButton *)button {
    self.cancelButtonBlock();
}
- (void)sureAction:(UIButton *)button {
    self.sureButtonBlock();
}
#pragma mark UIPickerViewDataSource和Delegate

//几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//几行
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.titleArray.count;
}
//标题
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.titleArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.string = self.titleArray[row];
}
- (NSString *)getCurrentTitle {
    return self.string;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
