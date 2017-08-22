//
//  ViewController.m
//  LoginView
//
//  Created by liushuai on 2017/8/22.
//  Copyright © 2017年 liushuai. All rights reserved.
//

#import "ViewController.h"

#define AVATAR_RADIUS 40
#define AVATAR_ORIGIN_Y 60
#define HEADER_HEIGHT  200
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HEADER_BG_COLOR [UIColor orangeColor]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController {
    UITableView *_tableView;
    UIView *_headerView;
    UIButton *_avatarBtn;
    UIView *_headerBgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}


- (void)setupTableView; {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    _headerBgView.backgroundColor = HEADER_BG_COLOR;
    [self.view addSubview:_headerBgView];

    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor clearColor];
    
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, HEADER_HEIGHT)];
    _headerView.backgroundColor = HEADER_BG_COLOR;
    _tableView.tableHeaderView = _headerView;
    
    _avatarBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.-AVATAR_RADIUS, AVATAR_ORIGIN_Y, AVATAR_RADIUS*2, AVATAR_RADIUS*2)];
    [_avatarBtn setImage:[UIImage imageNamed:@"husky.png"] forState:UIControlStateNormal];
    _avatarBtn.layer.cornerRadius = AVATAR_RADIUS;
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarBtn.layer.borderWidth = 2.;
    [_headerView addSubview:_avatarBtn];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = @"cell";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        CGFloat y =  - scrollView.contentOffset.y - scrollView.contentInset.top;
        _headerBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, y);
        
        //限制滑动缩放的范围
        if (scrollView.contentOffset.y < 0 && scrollView.contentOffset.y > -100) {
            _avatarBtn.frame = CGRectMake(SCREEN_WIDTH/2-AVATAR_RADIUS-y/2., AVATAR_ORIGIN_Y - y, AVATAR_RADIUS * 2 + y, AVATAR_RADIUS * 2 + y);
            _avatarBtn.layer.cornerRadius = _avatarBtn.frame.size.width/2.;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
