//
//  ViewController.m
//  AirPrintDemo
//
//  Created by linjianguo on 2018/7/5.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ViewController.h"
#import "yxgjView.h"
#import "ImgCollectionViewCell.h"
#import <SVProgressHUD.h>
#import "ToolManager.h"
@interface ViewController ()<UIPrintInteractionControllerDelegate,yxgjViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
/** jsArray **/
@property (nonatomic, strong) NSArray *jsArray;
/** 选择的图片 **/
@property (nonatomic, strong) NSString *selectStr;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UIView *bgView;
@end
/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

static NSString *ImgCollectionViewCellID = @"ImgCollectionViewCell";

@implementation ViewController

- (UICollectionView *)collectionV
{
    if (!_collectionV) {

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake(1.3333 * (ScreenH - 300 - 20), ScreenH - 300 - 20);
        
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionV.frame = CGRectMake(0, 150, ScreenW, ScreenH - 300);
        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.pagingEnabled = YES;
        _collectionV.showsHorizontalScrollIndicator = NO;
        [_collectionV registerClass:[ImgCollectionViewCell class] forCellWithReuseIdentifier:ImgCollectionViewCellID];
        
    }
    return _collectionV;
}
- (NSMutableArray *)imgs
{
    if (!_imgs) {
        _imgs = [NSMutableArray new];
        for (int i = 1; i < 8; i++) {
            NSString *str = [NSString stringWithFormat:@"打印图/图片%d.jpg",i];
            [self.imgs addObject:str];
        }
    }
    return _imgs;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}



- (void)printFromView
{
    
    [self.view endEditing:YES];
    
    
    if (self.selectStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择户型"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"打印图/0-3按揭表-打印-1" ofType:@"jpg"];
//    NSData *myData = [NSData dataWithContentsOfFile: path];
    
    
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    pic.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.orientation = UIPrintInfoOrientationPortrait;
    printInfo.jobName = @"图片1";
    pic.printInfo = printInfo;
    /*
    UIMarkupTextPrintFormatter *htmlFormatter = [[UIMarkupTextPrintFormatter alloc]
                                                 initWithMarkupText:self.htmlString];
    htmlFormatter.startPage = 0;
    htmlFormatter.contentInsets = UIEdgeInsetsMake(72.0, 72.0, 72.0, 72.0); // 1 inch margins
    
    pic.printFormatter = htmlFormatter;
    */
    pic.showsPageRange = YES;
    
    //单价
    NSString *danjia = self.jsArray[1];
    NSString *danjianew = [NSString stringWithFormat:@"%ld万",danjia.integerValue/10000];
    //总房价
    NSString *zongfangjia = [NSString stringWithFormat:@"%ld万",[self.jsArray[0] integerValue]/10000];
    //年数
    NSString *nianshu = [NSString stringWithFormat:@"%ld年",[self.jsArray[6] integerValue] / 12];
    //设置图片
    pic.printingItem = [[ToolManager shareInstance] getImgNormalImg:@"打印图/0-3按揭表-打印-1.jpg" hxImg:@"打印图/A2户型.jpg" leibie:self.jsArray.lastObject fanghao:@"001" mianji:self.jsArray[2] danjia:danjianew zongfangjia:zongfangjia shoufu:self.jsArray[5] nianshu:nianshu yuegong:self.jsArray[7]];

    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            NSLog(@"Printing could not complete because of error: %@", error);
        }
    };
    /*
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [pic presentFromBarButtonItem:sender animated:YES completionHandler:completionHandler];
    } else {
        [pic presentAnimated:YES completionHandler:completionHandler];
    }
    */
    [pic presentFromRect:self.view.bounds inView:self.view animated:YES completionHandler:completionHandler];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    yxgjView *y = [[yxgjView alloc] initWithFrame:self.view.bounds];
    y.delegate = self;
    [self.view addSubview:y];
    
    _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:_bgView];
    [self.view bringSubviewToFront:_bgView];
    [_bgView addSubview:self.collectionV];
    _bgView.hidden = YES;
    
    
    
}

- (void)clickBtnAction:(UIButton *)sender jsString:(NSString *)jsStr
{
    // 总价  单价  面积  折后优惠  折扣 贷款月数
    self.jsArray = [jsStr componentsSeparatedByString:@"-"];
    
//    if ([self.jsArray.firstObject isEqualToString:@""]) {
//
//        [SVProgressHUD showErrorWithStatus:@"请先计算价格"];
//        [SVProgressHUD dismissWithDelay:1.0];
//        return;
//    }
    
    for (NSString *str in self.jsArray) {
        NSLog(@"%@",str);
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.hidden = NO;
    }];
}

- (void)printBtnAction:(UIButton *)sender
{
    [self printFromView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgs.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    ImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImgCollectionViewCellID forIndexPath:indexPath];
    cell.imagStr = self.imgs[indexPath.item];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.bgView.hidden = YES;
    //获取选中的img
    self.selectStr = self.imgs[indexPath.item];
}





















@end
