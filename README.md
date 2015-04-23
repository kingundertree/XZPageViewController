#### XZPageViewController

主要通过UIPageViewController实现

1.设置导航宽度
	
	- (float)numOfPages;

2.设置导航宽度
	
	- (float)witdhOfNav;

3.导航标题
	
	- (NSString *)titleOfNavAtIndex:(NSInteger)index;

4.设置viewController
	
	- (UIViewController *)viewPageController:(XZPageViewController *)pageViewController contentViewControllerForNavAtIndex:(NSInteger)index;

5.是否循环
	
	- (BOOL)canPageViewControllerRecycle;

6.导航切换，viewcontroller是否动画展示
	
	- (BOOL)canPageViewControllerAnimation;

![Mou icon](https://github.com/kingundertree/XZPageViewController/blob/master/pageControl.gif)
