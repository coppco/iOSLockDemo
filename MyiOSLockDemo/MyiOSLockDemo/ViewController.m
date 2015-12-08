//
//  ViewController.m
//  MyiOSLockDemo
//
//  Created by M-coppco on 15/12/3.
//  Copyright © 2015年 M-coppco. All rights reserved.
//

#import "ViewController.h"
#import "PickerView.h"  //选择视图
#import "LockController.h"  //锁

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *array;
@property (nonatomic, strong)PickerView *pickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = @[@"自动锁定", @"手势设置"];
    self.tableView.tableFooterView = [[UIView alloc] init];

    self.pickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, kCHeight, kCWidth, kCHeight * 0.4)];
    self.pickerView.alpha = 0;
    //取消
    __weak typeof(self) mySelf = self;
    [self.pickerView setCancelButtonBlock:^{
        [UIView animateWithDuration:0.5 animations:^{
            mySelf.pickerView.center = CGPointMake(kCWidth / 2, kCHeight + self.pickerView.bounds.size.height / 2);
        } completion:^(BOOL finished) {
            mySelf.pickerView.alpha = 0;
            mySelf.tableView.userInteractionEnabled = YES;
            [mySelf.pickerView removeFromSuperview];
        }];
    }];
    //确定
    [self.pickerView setSureButtonBlock:^{
         [[NSUserDefaults standardUserDefaults] setObject:[mySelf.pickerView getCurrentTitle] forKey:@"backTime"];
        mySelf.pickerView.cancelButtonBlock();
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark UITableViewDataSource和Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *rereusing = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rereusing];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:rereusing];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //设置一个pickController
        [self addsubView];
        
    }
    if (indexPath.row == 1) {
        LockController *lockVC = [[LockController alloc] init];
        [self.navigationController pushViewController:lockVC animated:YES];
        
    }
    //取消tableView的高亮状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//
- (void)addsubView {
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"backTime"]);
    [self.view addSubview:self.pickerView];
    self.pickerView.alpha = 1;
    self.tableView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5  animations:^{
        self.pickerView.center = CGPointMake(kCWidth / 2, kCHeight - self.pickerView.bounds.size.height / 2);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
