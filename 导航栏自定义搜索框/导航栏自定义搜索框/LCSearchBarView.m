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
        [self.textFiled addTarget:self action:@selector(searchBarViewClicked:) forControlEvents:(UIControlEventTouchUpInside)];
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
-(void)setFont:(UIFont *)font{
    _font = font;
    self.textFiled.font = font;
    [self.textFiled setValue:font forKeyPath:@"_placeholderLabel.font"];
}
-(void)setText:(NSString *)text{
    _text = text;
    self.textFiled.text = text;
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.textFiled.textColor = textColor;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textFiled.placeholder = placeholder;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self.textFiled setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)setSearchBarViewColor:(UIColor *)searchBarViewColor{
    _searchBarViewColor = searchBarViewColor;
    self.backgroundColor = searchBarViewColor;
}

/** 是否弹出键盘 */
-(void)setIsBecomeFirstResponder:(BOOL)isBecomeFirstResponder{
    _isBecomeFirstResponder = isBecomeFirstResponder;
    if (isBecomeFirstResponder) {
        [self.textFiled becomeFirstResponder];
    }else{
        [self.textFiled resignFirstResponder];
    }
}

/** 是否显示关闭按钮 */
-(void)setIsShowCloseImage:(BOOL)isShowCloseImage{
    _isShowCloseImage = isShowCloseImage;
    if (isShowCloseImage) {
        self.closeBtn.hidden = YES;
    }else{
        self.closeBtn.hidden = NO;
    }
}
/** 关闭按钮图片 */
-(void)setCloseImage:(UIImage *)closeImage{
    _closeImage = closeImage;
    [self.closeBtn setImage:closeImage forState:(UIControlStateNormal)];
}

#pragma mark - <按钮触发方法>
/** 点击关闭按钮时触发 */
-(void)closeClick{
    if ([_searchBarDelegate respondsToSelector:@selector(lc_searchBarViewCancelButtonClicked:)]) {
        [self.searchBarDelegate lc_searchBarViewCancelButtonClicked:self];
    }
}
/** 输入文字改变时触发 */
-(void)textFiledValueChange:(UITextField *)textFiled{
    
    _text = textFiled.text;
    if ([_searchBarDelegate respondsToSelector:@selector(lc_searchBarView:textDidChange:)]) {
        [self.searchBarDelegate lc_searchBarView:self textDidChange:textFiled.text];
    }
}

#pragma mark - <LCSearchBarViewDelegate>
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([_searchBarDelegate respondsToSelector:@selector(lc_searchBarViewShouldBeginEditing:)]) {
        [self.searchBarDelegate lc_searchBarViewShouldBeginEditing:self];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_searchBarDelegate respondsToSelector:@selector(lc_searchBarViewDidBeginEditing:)]) {
        [self.searchBarDelegate lc_searchBarViewDidBeginEditing:self];
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([_searchBarDelegate respondsToSelector:@selector(lc_searchBarViewShouldEndEditing:)]) {
        [self.searchBarDelegate lc_searchBarViewShouldEndEditing:self];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([_searchBarDelegate respondsToSelector:@selector(lc_searchBarViewDidEndEditing:)]) {
        [self.searchBarDelegate lc_searchBarViewDidEndEditing:self];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_searchBarDelegate respondsToSelector:@selector(lc_searchBarViewSearchButtonClicked:)]) {
        [self.searchBarDelegate lc_searchBarViewSearchButtonClicked:self];
    }
    return YES;
}


@end
