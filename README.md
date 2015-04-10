#### XZPageViewController

主要通过UIPageViewController实现

1.导航宽度
	
	- (float)witdhOfNav;
	设备导航栏tab款地

2.导航标题
	
	- (NSString *)titleOfNavAtIndex:(NSInteger)index;
	设备导航栏tab标题

3.控制器视图
	
	- (UIViewController *)viewPageController:(XZPageViewController *)pageViewController contentViewControllerForNavAtIndex:(NSInteger)index;
	返回导航栏对应的viewcontroller

4.是否循环
	
	- (BOOL)canPageViewControllerRecycle;
	是否支持viewcontroller循环滚动

5.导航切换，viewcontroller是否动画展示
	
	- (BOOL)canPageViewControllerAnimation;
	viewcontroller是否以动画效果展现

![Mou icon](https://github.com/kingundertree/XZPageViewController/blob/master/pageControl.gif)
