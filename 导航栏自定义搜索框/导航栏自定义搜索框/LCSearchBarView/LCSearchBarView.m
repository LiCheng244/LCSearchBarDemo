//
//  LCSearchBarView.m
//  导航栏自定义搜索框
//
//  Created by LiCheng on 2017/1/3.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCSearchBarView.h"


#define ImageWith 20
#define IntervalMargin 10
#define TopMargin 2

#define ViewWith self.frame.size.width
#define ViewHeight self.frame.size.height



@interface LCSearchBarView ()<UITextFieldDelegate>

/** 搜索图片 */
@property (nonatomic, strong)  UIImageView *leftImgView;
/** 输入框 */
@property (nonatomic, strong)  UITextField *textFiled;
/** 关闭按钮 */
@property (nonatomic, strong)  UIButton *closeBtn;

@end


@implementation LCSearchBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSearchBarView];
    }
    return self;
}

/** 初始化搜索框 */
-(void)setupSearchBarView{
    
    // 设置圆角
    self.layer.cornerRadius = ViewHeight / 2;
    self.layer.masksToBounds = YES;
    
    // 搜索图片
    if (self.leftImgView == nil) {
        self.leftImgView = [[UIImageView alloc] initWithFrame:(CGRectMake(IntervalMargin, (ViewHeight - ImageWith)/2, ImageWith, ImageWith))];
        self.leftImgView.image = [UIImage imageNamed:@"search"];
        [self addSubview:self.leftImgView];
    }
    
    // 输入框
    if (self.textFiled == nil) {
        CGFloat textFiledX = CGRectGetMaxX(self.leftImgView.frame) + 10;
        CGFloat textFiledY = 2;
        CGFloat textFiledW = ViewWith - (CGRectGetMaxX(self.leftImgView.frame));
        CGFloat textFiledH = ViewHeight - 4;
        self.textFiled = [[UITextField alloc] initWithFrame:(CGRectMake(textFiledX, textFiledY, textFiledW, textFiledH))];
        self.textFiled.backgroundColor = [UIColor clearColor];
        self.textFiled.delegate = self;
        self.textFiled.returnKeyType = UIReturnKeyDone;
        [self.textFiled addTarget:self action:@selector(textFiledValueChange:) forControlEvents:(UIControlEventEditingChanged)];
        [self addSubview:self.textFiled];
    }
    
    // 关闭按钮
    if (self.closeBtn == nil) {
        self.closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat closeBtnX = CGRectGetMaxX(self.textFiled.frame)  - ImageWith - IntervalMargin * 2;
        CGFloat closeBtnY = (ViewHeight - ImageWith) / 2;
        self.closeBtn.frame = CGRectMake(closeBtnX,closeBtnY, ImageWith, ImageWith);
        self.closeBtn.backgroundColor = [UIColor clearColor];
        [self.closeBtn setImage:[UIImage imageNamed:@"close"] forState:(UIControlStateNormal)];
        [self.closeBtn addTarget:self action:@selector(closeClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.closeBtn];
    }
}

#pragma mark - <set方法>
-(void)setLc_font:(UIFont *)lc_font{
    _lc_font = lc_font;
    self.textFiled.font = lc_font;
    [self.textFiled setValue:lc_font forKeyPath:@"_placeholderLabel.font"];
}

-(void)setLc_text:(NSString *)lc_text{
    _lc_text = lc_text;
    self.textFiled.text = lc_text;
}
-(void)setLc_tintColor:(UIColor *)lc_tintColor{
    _lc_tintColor = lc_tintColor;
    self.textFiled.tintColor = lc_tintColor;
}

-(void)setLc_textColor:(UIColor *)lc_textColor{
    _lc_textColor = lc_textColor;
    self.textFiled.textColor = lc_textColor;
}

-(void)setLc_placeholder:(NSString *)lc_placeholder{
    _lc_placeholder = lc_placeholder;
    self.textFiled.placeholder = lc_placeholder;
}

-(void)setLc_placeholderColor:(UIColor *)lc_placeholderColor{
    _lc_placeholderColor = lc_placeholderColor;
    [self.textFiled setValue:lc_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)setLc_backgroundColor:(UIColor *)lc_backgroundColor{
    _lc_backgroundColor = lc_backgroundColor;
    self.backgroundColor = lc_backgroundColor;
}

/** 是否弹出键盘 */
-(void)setLc_isFirstResponder:(BOOL)lc_isFirstResponder{
    lc_isFirstResponder = lc_isFirstResponder;
    if (lc_isFirstResponder) {
        [self.textFiled becomeFirstResponder];
    }else{
        [self.textFiled resignFirstResponder];
    }
}

/** 是否显示关闭按钮 */
-(void)setLc_isShowCloseImage:(BOOL)lc_isShowCloseImage{
    _lc_isShowCloseImage = lc_isShowCloseImage;
    if (lc_isShowCloseImage) {
        self.closeBtn.hidden = NO;
    }else{
        self.closeBtn.hidden = YES;
    }
}
/** 关闭按钮图片 */
-(void)setLc_closeImage:(UIImage *)lc_closeImage{
    _lc_closeImage = lc_closeImage;
    [self.closeBtn setImage:lc_closeImage forState:(UIControlStateNormal)];
}


#pragma mark - <按钮触发方法>
/** 点击关闭按钮时触发 */
-(void)closeClick{
    if ([_lc_delegate respondsToSelector:@selector(lc_searchBarViewCancelButtonClicked:)]) {
        [self.lc_delegate lc_searchBarViewCancelButtonClicked:self];
    }
}
/** 输入文字改变时触发 */
-(void)textFiledValueChange:(UITextField *)textFiled{
    
    _lc_text = textFiled.text;
    if ([_lc_delegate respondsToSelector:@selector(lc_searchBarView:textDidChange:)]) {
        [self.lc_delegate lc_searchBarView:self textDidChange:textFiled.text];
    }
}

#pragma mark - <LCSearchBarViewDelegate>
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([_lc_delegate respondsToSelector:@selector(lc_searchBarViewShouldBeginEditing:)]) {
        [self.lc_delegate lc_searchBarViewShouldBeginEditing:self];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_lc_delegate respondsToSelector:@selector(lc_searchBarViewDidBeginEditing:)]) {
        [self.lc_delegate lc_searchBarViewDidBeginEditing:self];
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([_lc_delegate respondsToSelector:@selector(lc_searchBarViewShouldEndEditing:)]) {
        [self.lc_delegate lc_searchBarViewShouldEndEditing:self];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([_lc_delegate respondsToSelector:@selector(lc_searchBarViewDidEndEditing:)]) {
        [self.lc_delegate lc_searchBarViewDidEndEditing:self];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_lc_delegate respondsToSelector:@selector(lc_searchBarViewSearchButtonClicked:)]) {
        [self.lc_delegate lc_searchBarViewSearchButtonClicked:self];
    }
    return YES;
}


@end
