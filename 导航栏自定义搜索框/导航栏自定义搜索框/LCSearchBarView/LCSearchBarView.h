//
//  LCSearchBarView.h
//  导航栏自定义搜索框
//
//  Created by LiCheng on 2017/1/3.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCSearchBarView;
/** 代理 */
@protocol LCSearchBarViewDelegate <NSObject>

@optional

-(BOOL)lc_searchBarViewShouldBeginEditing:(LCSearchBarView *)searchBarView;
-(void)lc_searchBarViewDidBeginEditing:(LCSearchBarView *)searchBarView;
-(void)lc_searchBarViewShouldEndEditing:(LCSearchBarView *)searchBarView;
-(void)lc_searchBarViewDidEndEditing:(LCSearchBarView *)searchBarView;

/** 输入框内容改变时触发的代理方法 */
-(void)lc_searchBarView:(LCSearchBarView *)searchBarView textDidChange:(NSString *)searchText;

/** 搜索按钮触发的代理方法 */
-(void)lc_searchBarViewSearchButtonClicked:(LCSearchBarView *)searchBarView;
/** 关闭按钮触发的代理方法 */
-(void)lc_searchBarViewCancelButtonClicked:(LCSearchBarView *)searchBarView;


@end

@interface LCSearchBarView : UIView

/** 内容 */
@property (nonatomic, strong) NSString *lc_text;
/** 字体 */
@property (nonatomic, strong) UIFont *lc_font;
/** 光标颜色 */
@property (nonatomic, strong)  UIColor *lc_tintColor;
/** 内容颜色 */
@property (nonatomic, strong) UIColor *lc_textColor;
/** 占位文字 */
@property (nonatomic, strong) NSString *lc_placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *lc_placeholderColor;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *lc_backgroundColor;

/** 是否弹出键盘 */
@property (nonatomic, assign) BOOL lc_isFirstResponder;

/** 是否显示关闭按钮 */
@property (nonatomic, assign) BOOL lc_isShowCloseImage;
/** 关闭按钮样式 */
@property (nonatomic, strong) UIImage *lc_closeImage;

/** 代理 */
@property (nonatomic, weak) id<LCSearchBarViewDelegate>lc_delegate;


@end
