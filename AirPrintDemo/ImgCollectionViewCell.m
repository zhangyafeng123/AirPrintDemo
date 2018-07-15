//
//  ImgCollectionViewCell.m
//  AirPrintDemo
//
//  Created by linjianguo on 2018/7/6.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ImgCollectionViewCell.h"


@interface ImgCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imgvvv;

@end


@implementation ImgCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.imgvvv = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imgvvv];
}
- (void)setImagStr:(NSString *)imagStr
{
    _imagStr = imagStr;
    self.imgvvv.image = [UIImage imageNamed:imagStr];
    
}


@end
