//
//  yxgjView.m
//  jcgjzyc
//
//  Created by linjianguo on 2018/5/8.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "yxgjView.h"

@interface yxgjView ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webV;
@end

@implementation yxgjView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        UIWebView *WebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        WebView.delegate = self;
        [WebView setUserInteractionEnabled:YES];
        [WebView setBackgroundColor:[UIColor blackColor]];
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"cal" ofType:@"html"];
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        WebView.scalesPageToFit=YES;
        [WebView setUserInteractionEnabled:YES];
        [WebView setOpaque:NO];
        [WebView loadHTMLString:htmlCont baseURL:baseURL];
        [self addSubview:WebView];
        
        self.webV = WebView;
        
        UIButton *backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backbtn.backgroundColor = [UIColor clearColor];
        [backbtn setTitle:@"选择户型" forState:(UIControlStateNormal)];
        [backbtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
       
        backbtn.frame = CGRectMake(1024 - 150, 768 - 60, 120, 50);
        [backbtn addTarget:self action:@selector(backbtnaction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:backbtn];
        
        
        UIButton *print = [UIButton buttonWithType:(UIButtonTypeCustom)];
        print.backgroundColor = [UIColor clearColor];
        [print setTitle:@"立即打印" forState:(UIControlStateNormal)];
        [print setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        
        print.frame = CGRectMake(1024 - 150, 60, 120, 50);
        [print addTarget:self action:@selector(printAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:print];
        
    }
    return self;
}
- (void)printAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(printBtnAction:)]) {
        [self.delegate printBtnAction:sender];
    }
}
- (void)backbtnaction:(UIButton *)sender
{
    //贷款类别
    NSString *str2 = [self.webV stringByEvaluatingJavaScriptFromString:@"LoanType();"];
    //最后计算
    NSString *str1 = [self.webV stringByEvaluatingJavaScriptFromString:@"cal();"];
    
    NSString *newstr = [str1 stringByAppendingString:[NSString stringWithFormat:@"-%@",str2]];
    // 总价  单价  面积  折后优惠  折扣 贷款月数
    //贷款期限
//    NSString *str3 = [self.webV stringByEvaluatingJavaScriptFromString:@"nxListLi();"];
    
    NSLog(@"打印:%@",newstr);
    
    if ([self.delegate respondsToSelector:@selector(clickBtnAction: jsString:)]) {
        [self.delegate clickBtnAction:sender jsString:newstr];
    }
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    //获取所有的html
//    NSString *allHtml = @"document.documentElement.innerHTML";
//    //获取网页的一个值
//    NSString *htmlNum = @"document.getElementById('title').innerText";
//
//}
@end
