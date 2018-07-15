//
//  FirstViewController.m
//  AirPrintDemo
//
//  Created by linjianguo on 2018/7/6.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "FirstViewController.h"
#import "ToolManager.h"
@interface FirstViewController ()
@property (nonatomic, strong) UIScrollView *scrollview;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollview.contentSize  = CGSizeMake(2480/2, 3508/2);
    [self.view addSubview:self.scrollview];
    
    
    //CGFloat fff = 1.414;//1.414 //3508/2480
    //2480 × 3508
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 2480/2, 3508/2)];
   
    //设置图片
    imgv.image = [[ToolManager shareInstance] getImgNormalImg:@"打印底图.jpg" hxImg:@"8#.jpg" leibie:@"商业贷款" fanghao:@"001" mianji:@"100" danjia:@"1万" zongfangjia:@"89万" shoufu:@"34万" nianshu:@"3年" yuegong:@"6744元"];
    
    [self.scrollview addSubview:imgv];

}


@end
