//
//  yxgjView.h
//  jcgjzyc
//
//  Created by linjianguo on 2018/5/8.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol yxgjViewDelegate <NSObject>

- (void)clickBtnAction:(UIButton *)sender jsString:(NSString *)jsStr;
- (void)printBtnAction:(UIButton *)sender;

@end


@interface yxgjView : UIView

@property(nonatomic, weak) id<yxgjViewDelegate> delegate;

@end
