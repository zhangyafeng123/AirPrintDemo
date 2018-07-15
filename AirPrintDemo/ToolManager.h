//
//  ToolManager.h
//  AirPrintDemo
//
//  Created by linjianguo on 2018/7/8.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ToolManager : NSObject
+ (instancetype)shareInstance;


- (UIImage *)getImgNormalImg:(NSString *)normalImgStr hxImg:(NSString *)hxImgStr leibie:(NSString *)leibieStr fanghao:(NSString *)fanghaoStr mianji:(NSString *)mianjiStr danjia:(NSString *)danjiaStr zongfangjia:(NSString *)zongfangjiaStr shoufu:(NSString *)shoufuStr nianshu:(NSString *)nianshuStr yuegong:(NSString *)yuegongStr;
@end
