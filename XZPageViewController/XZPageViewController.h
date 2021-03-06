//
//  XZPageViewController.h
//  XZPageViewController
//
//  Created by xiazer on 15/4/9.
//  Copyright (c) 2015年 anjuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZPageViewControllerDataSource;
@protocol XZPageViewControllerDelegate;

@interface XZPageViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *viewControllerArr;
@property (nonatomic, strong) UIScrollView *navScrollView;
@property (nonatomic, strong) NSMutableArray *navTitleViewsArr;
@property (nonatomic, strong) NSMutableArray *navTitlesArr;
@property (nonatomic, assign) id<XZPageViewControllerDataSource> dataSource;
@property (nonatomic, assign) id<XZPageViewControllerDelegate> delegate;

@end

@protocol XZPageViewControllerDataSource <NSObject>
// 导航数
- (NSInteger)numOfPages;
// 导航宽度
- (float)witdhOfNav;
// 导航标题
- (NSString *)titleOfNavAtIndex:(NSInteger)index;
// pageViewController
- (UIViewController *)viewPageController:(XZPageViewController *)pageViewController contentViewControllerForNavAtIndex:(NSInteger)index;
// 是否循环
- (BOOL)canPageViewControllerRecycle;
// 是否动画切换
- (BOOL)canPageViewControllerAnimation;
@end

@protocol XZPageViewControllerDelegate <NSObject>
@optional
- (UIViewController *)viewPageController:(XZPageViewController *)pageViewController pageViewControllerChangedAtIndex:(NSInteger)index;
@end