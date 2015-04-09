//
//  XZPageViewController.m
//  XZPageViewController
//
//  Created by xiazer on 15/4/9.
//  Copyright (c) 2015年 anjuke. All rights reserved.
//

#import "XZPageViewController.h"

//定义屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//定义屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define navHeight 44.0


@interface XZPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) NSInteger navCount;
@property (nonatomic, assign) float navWidth;
@property (nonatomic, assign) NSInteger currentVCIndex;

@end

@implementation XZPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self loadNavScrollView];
    [self loadPageViewController];
}

#pragma mark - method
- (void)initData {
    self.currentVCIndex = -0;
    self.navTitleViewsArr = [NSMutableArray array];
    self.viewControllerArr = [NSMutableArray array];
    self.navCount = self.navTitlesArr.count;
    self.navWidth = [self.dataSource witdhOfNav];
}
- (void)loadNavScrollView {
    self.navScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, navHeight)];
    self.navScrollView.delegate = self;
    self.navScrollView.backgroundColor = [UIColor clearColor];
    self.navScrollView.showsHorizontalScrollIndicator = NO;
    self.navScrollView.contentSize = CGSizeMake((self.navCount -1)*self.navWidth+ScreenWidth, navHeight);
    
    self.navigationItem.titleView = self.navScrollView;
    
    for (NSInteger i = 0; i < self.navCount; i++) {
        UILabel *navTitLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+self.navWidth*(i-0.5), 0, self.navWidth, navHeight)];
        navTitLab.backgroundColor = [UIColor whiteColor];
        navTitLab.text = [self.navTitlesArr objectAtIndexedSubscript:i];
        navTitLab.font = [UIFont systemFontOfSize:18];
        navTitLab.textColor = [UIColor blackColor];
        navTitLab.textAlignment = NSTextAlignmentCenter;
        [self.navScrollView addSubview:navTitLab];
    
        [self.navTitleViewsArr addObject:navTitLab];
    }
    
    [self navTitSelectedAtIndex:0];
}

- (void)navTitSelectedAtIndex:(NSInteger)index {
    CGPoint point = CGPointMake(index*self.navWidth, 0);
    
    for (NSInteger i = 0; i < self.navCount; i++) {
        UILabel *titLab = [self.navTitleViewsArr objectAtIndex:i];
        titLab.textColor = [UIColor blackColor];
    }
    
    UILabel *titLab = [self.navTitleViewsArr objectAtIndex:index];

    [UIView animateWithDuration:0.3 animations:^{
        self.navScrollView.contentOffset = point;
        titLab.textColor = [UIColor redColor];
        titLab.font = [UIFont systemFontOfSize:20];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)loadPageViewController {
    for (NSInteger i = 0; i < self.navCount; i++) {
        UIViewController *vc = [self.dataSource viewPageController:self contentViewControllerForNavAtIndex:i];
        [self.viewControllerArr addObject:vc];
    }

    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self addChildViewController:self.pageViewController];

    ((UIScrollView *)[self.pageViewController.view.subviews objectAtIndex:0]).delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.contentView = self.pageViewController.view;
    [self.view addSubview:self.contentView];

    [self transitionToViewControllerAtIndex:0];
}

- (void)transitionToViewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = [self viewControllerAtIndex:index];
    
    if (!viewController) {
        viewController = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
        viewController.view.backgroundColor = [UIColor redColor];
    }
    
    if (index == self.currentVCIndex) {
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:^(BOOL finished) {
                                         }];
    } else {
        NSInteger direction = 0;
        if (index == self.viewControllerArr.count - 1 && self.currentVCIndex == 0) {
            direction = UIPageViewControllerNavigationDirectionReverse;
        } else if (index == 0 && self.currentVCIndex == self.viewControllerArr.count - 1) {
            direction = UIPageViewControllerNavigationDirectionForward;
        } else if (index < self.currentVCIndex) {
            direction = UIPageViewControllerNavigationDirectionReverse;
        } else {
            direction = UIPageViewControllerNavigationDirectionForward;
        }
        
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:direction
                                           animated:YES
                                         completion:^(BOOL completed){// none
                                         }];
    }
    
    self.currentVCIndex = index;
}

- (NSInteger)indexOfViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllerArr indexOfObject:viewController];
    return index;
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    UIViewController *vc = [self.viewControllerArr objectAtIndex:index];
    return vc;
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:viewController];
    if (index == self.navCount - 1) {
        index = 0;
    } else {
        index++;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:viewController];
    if (index == 0) {
        index = self.navCount - 1;
    } else {
        index--;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}


#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
}
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return nil;
}

- (NSUInteger)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
    return 0;
}

- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
