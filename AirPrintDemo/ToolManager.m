//
//  ToolManager.m
//  AirPrintDemo
//
//  Created by linjianguo on 2018/7/8.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ToolManager.h"

@implementation ToolManager
static ToolManager *singleClass =nil;

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        singleClass = [[ToolManager alloc] init];
        
    });
    
    return singleClass;
    
}
/**
 原来的图片
 户型图片
 贷款类别
 按揭方式
 房号
 面积
 单价
 总房价
 首付
 按揭成数
 按揭年数
 月供
 **/

- (UIImage *)getImgNormalImg:(NSString *)normalImgStr hxImg:(NSString *)hxImgStr leibie:(NSString *)leibieStr fanghao:(NSString *)fanghaoStr mianji:(NSString *)mianjiStr danjia:(NSString *)danjiaStr zongfangjia:(NSString *)zongfangjiaStr shoufu:(NSString *)shoufuStr nianshu:(NSString *)nianshuStr yuegong:(NSString *)yuegongStr
{
    //合成图片
    UIImage *img1 = [self addImageLogo:[UIImage imageNamed:normalImgStr] text:[UIImage imageNamed:hxImgStr]];
    //贷款类别:
    UIImage *leibie = [self addWaterText:leibieStr Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0],NSForegroundColorAttributeName:[UIColor whiteColor]} toImage:img1 rect:CGRectMake(680, 1330, 200, 40)];
    //房号
    UIImage *fanghao = [self addWaterText:fanghaoStr Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} toImage:leibie rect:CGRectMake(175/2, 1445, 100, 40)];
    
    //建筑面积
    UIImage *mianji = [self addWaterText:mianjiStr Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} toImage:fanghao rect:CGRectMake(260, 1445, 100, 40)];
    //单价
    UIImage *danjia = [self addWaterText:danjiaStr Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} toImage:mianji rect:CGRectMake(400, 1445, 100, 40)];
    //总房价
    UIImage *zongfangjia = [self addWaterText:zongfangjiaStr Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]} toImage:danjia rect:CGRectMake(530, 1445, 100, 40)];
    //首付
    UIImage *shoufu = [self addWaterText:shoufuStr Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} toImage:zongfangjia rect:CGRectMake(680, 1445, 100, 40)];
    
    //按揭年数
    UIImage *nianshu = [self addWaterText:nianshuStr Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} toImage:shoufu rect:CGRectMake(890, 1445, 100, 40)];
    
    //月供
    UIImage *yuegong = [self addWaterText:yuegongStr Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} toImage:nianshu rect:CGRectMake(1080, 1445, 100, 40)];
    return yuegong;
    
    
}
//添加文字水印到指定图片上
-(UIImage *)addWaterText:(NSString *)text Attributes:(NSDictionary*)atts toImage:(UIImage *)img rect:(CGRect)rect{
    
    CGFloat height = img.size.height;
    CGFloat width = img.size.width;
    
    //开启一个图形上下文
    UIGraphicsBeginImageContext(img.size);
    
    //在图片上下文中绘制图片
    [img drawInRect:CGRectMake(0, 0,width,height)];
    
    //在图片的指定位置绘制文字   -- 7.0以后才有这个方法
    [text drawInRect:rect withAttributes:atts];
    
    //从图形上下文拿到最终的图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图片上下文
    UIGraphicsEndImageContext();
    
    return newImg;
}


/**
 在一张图片上添加logo或者水印；
 添加文字也可以这么做，让美工做一张文字图片即可
 warn 不支持jpg的图片
 
 @param image     原始的图片
 @param logoImage 要添加的logo
 @return 返回一张新的图片
 */
-(UIImage *)addImageLogo:(UIImage *)image text:(UIImage *)logoImage
{
    //原始图片的宽和高，可以根据需求自己定义
    //2480, 3508
    CGFloat w = 1240;
    CGFloat h = 1754;
    //logo的宽和高，也可以根据需求自己定义 2203 × 2118
    CGFloat logoWidth = 918; //881
    CGFloat logoHeight = 883; //711
    //绘制
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    //绘制的logo位置,可自己调整
    CGContextDrawImage(context, CGRectMake( (w - logoWidth) / 2, (h - logoHeight) / 2 + 100, logoWidth, logoHeight), [logoImage CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

@end
