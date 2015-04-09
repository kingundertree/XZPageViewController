//
//  XZDetailViewController.m
//  XZPageViewController
//
//  Created by xiazer on 15/4/9.
//  Copyright (c) 2015年 anjuke. All rights reserved.
//

#import "XZDetailViewController.h"

@interface XZDetailViewController ()
@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation XZDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.titleLab = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.titleLab.backgroundColor = [UIColor whiteColor];
    self.titleLab.font = [UIFont boldSystemFontOfSize:200];
    self.titleLab.textColor = [UIColor orangeColor];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLab];
}

- (void)setTitle:(NSString *)title {
    _titleStr = title;
    
    self.titleLab.text = _titleStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
