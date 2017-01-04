//
//  SearchResultViewController.m
//  导航栏自定义搜索框
//
//  Created by LiCheng on 2017/1/3.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "SearchResultViewController.h"
#import "LCSearchBarView.h"

@interface SearchResultViewController ()<LCSearchBarViewDelegate>

/** <#description#> */
@property (nonatomic, strong) LCSearchBarView *searchBarView;
@end

@implementation SearchResultViewController

-(void)viewDidAppear:(BOOL)animated{
    self.searchBarView.isBecomeFirstResponder = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.searchBarView.isBecomeFirstResponder = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.searchBarView = [[LCSearchBarView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width - 80, 30))];
    self.searchBarView.backgroundColor = [UIColor colorWithRed:205/255.0 green:235/255.0 blue:206/255.0 alpha:1];
    self.searchBarView.textColor = [UIColor whiteColor];
    self.searchBarView.placeholder = @"搜索";
    self.searchBarView.font = [UIFont systemFontOfSize:15];
    self.searchBarView.placeholderColor = [UIColor grayColor];
    self.searchBarView.searchBarDelegate = self;
    self.navigationItem.titleView = self.searchBarView;
}

-(void)lc_searchBarViewCancelButtonClicked:(LCSearchBarView *)searchBarView{
    
    self.searchBarView.isBecomeFirstResponder = NO;
    
}


@end
