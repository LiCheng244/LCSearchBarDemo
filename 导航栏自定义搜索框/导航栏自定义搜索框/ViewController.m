//
//  ViewController.m
//  导航栏自定义搜索框
//
//  Created by LiCheng on 2017/1/3.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "ViewController.h"
#import "LCSearchBarView.h"
#import "SearchResultViewController.h"

@interface ViewController ()<LCSearchBarViewDelegate>

/** 搜索框 */
@property (nonatomic, strong)  LCSearchBarView *searchBarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"点击" forState:(UIControlStateNormal)];
    btn.backgroundColor = [UIColor cyanColor];
    btn.frame = CGRectMake( 100, 200, 100, 30);
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    self.searchBarView = [[LCSearchBarView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width - 80, 30))];
    self.searchBarView.backgroundColor = [UIColor colorWithRed:255/255.0 green:132/255.0 blue:0/255.0 alpha:0.5];
    self.searchBarView.placeholderColor = [UIColor redColor];
    self.searchBarView.placeholder = @"搜索";
    self.searchBarView.font = [UIFont systemFontOfSize:15];
    self.searchBarView.textColor = [UIColor grayColor];
    self.searchBarView.isShowCloseImage = NO;
    self.searchBarView.searchBarDelegate = self;
    self.navigationItem.titleView = self.searchBarView;
}

-(void)click{
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)lc_searchBarViewSearchButtonClicked:(LCSearchBarView *)searchBarView{
    NSLog(@"搜索");
    // 微博搜索效果
    if (self.searchBarView.text.length == 0) {
        self.searchBarView.text = self.searchBarView.placeholder;
    }
    self.searchBarView.isBecomeFirstResponder = NO;

}

-(void)lc_searchBarViewCancelButtonClicked:(LCSearchBarView *)searchBarView{
    NSLog(@"取消");
    
    self.searchBarView.text = nil;
    self.searchBarView.isBecomeFirstResponder = NO;
}

-(BOOL)lc_searchBarViewShouldBeginEditing:(LCSearchBarView *)searchBarView{
    return YES;
}
-(void)lc_searchBarViewDidBeginEditing:(LCSearchBarView *)searchBarView{
    NSLog(@"33333");
}
-(void)lc_searchBarViewShouldEndEditing:(LCSearchBarView *)searchBarView{
    NSLog(@"11111");
}
-(void)lc_searchBarViewDidEndEditing:(LCSearchBarView *)searchBarView{
    NSLog(@"44444");
}

-(void)lc_searchBarView:(LCSearchBarView *)searchBarView textDidChange:(NSString *)searchText{

}


@end
