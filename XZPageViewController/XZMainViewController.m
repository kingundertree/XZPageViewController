//
//  XZMainViewController.m
//  XZPageViewController
//
//  Created by xiazer on 15/4/9.
//  Copyright (c) 2015年 anjuke. All rights reserved.
//

#import "XZMainViewController.h"
#import "XZDetailViewController.h"
#import "XZWebViewController.h"

@interface XZMainViewController () <XZPageViewControllerDataSource, XZPageViewControllerDelegate>

@end

@implementation XZMainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *titArr = @[@"头条",@"上海",@"科技",@"经济",@"房产",@"自媒体",@"军事",@"体育",@"游戏",@"图片",@"时尚"];
        self.navTitlesArr = [NSMutableArray arrayWithArray:titArr];
        self.dataSource = self;
        self.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - XZPageViewControllerDataSource
- (NSInteger)numOfPages {
    return self.navTitlesArr.count;
}

- (float)witdhOfNav {
    return 60.0;
}
- (NSString *)titleOfNavAtIndex:(NSInteger)index {
    return [self.navTitlesArr objectAtIndex:index];
}
- (UIViewController *)viewPageController:(XZPageViewController *)pageViewController contentViewControllerForNavAtIndex:(NSInteger)index {
    if (index == 0) {
        XZWebViewController *webVC = [[XZWebViewController alloc] init];
        return webVC;
    } else {
        XZDetailViewController *detailVC = [[XZDetailViewController alloc] init];
        detailVC.title = [NSString stringWithFormat:@"%ld",(long)index];
        return detailVC;
    }
}

- (BOOL)canPageViewControllerRecycle {
    return NO;
}

- (BOOL)canPageViewControllerAnimation {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
