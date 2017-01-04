//
//  SearchResultViewController.m
//  导航栏自定义搜索框
//
//  Created by LiCheng on 2017/1/3.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "SearchResultViewController.h"
#import "LCSearchBarView.h"

@interface SearchResultViewController ()<LCSearchBarViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LCSearchBarView *searchBarView;
@end

@implementation SearchResultViewController

-(void)viewDidAppear:(BOOL)animated{
    self.searchBarView.lc_isFirstResponder = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.searchBarView.lc_isFirstResponder = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupSearchBarView];
    
}
-(void)setupTableView{
    self.view.backgroundColor = [UIColor grayColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
-(void)setupSearchBarView{
    
    self.searchBarView = [[LCSearchBarView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width - 80, 30))];
    self.searchBarView.lc_backgroundColor = [UIColor colorWithRed:205/255.0 green:235/255.0 blue:206/255.0 alpha:1];
    self.searchBarView.lc_textColor = [UIColor whiteColor];
    self.searchBarView.lc_placeholder = @"搜索";
    self.searchBarView.lc_placeholderColor = [UIColor grayColor];
    self.searchBarView.lc_font = [UIFont systemFontOfSize:15];
    self.searchBarView.lc_delegate = self;
    self.navigationItem.titleView = self.searchBarView;
}

-(void)lc_searchBarViewCancelButtonClicked:(LCSearchBarView *)searchBarView{
    self.searchBarView.lc_isFirstResponder = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld行数据结果", indexPath.row];
        return cell;

}





@end
