//
//  TopScrollerBaseLayout.m
//  TopFramework
//
//  Created by Makeitapp USA on 19/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopScrollerBaseLayout.h"
#import "TopLayoutFactory.h"

@interface TopScrollerBaseLayout ()<UIScrollViewDelegate>{
    NSArray <TopPage *> * _pages;
    NSInteger _currentPageIndex;
}
@property (nonatomic,weak) UIScrollView *mainScrollView;
@property (nonatomic,strong) NSMutableArray <BasePageViewController *>*controllers;
@end

@implementation TopScrollerBaseLayout
- (instancetype)initFromPages:(NSArray <TopPage *> *)pages
{
    self = [super init];
    if (self) {
        _pages = pages;
        self.controllers = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mainScrollView.backgroundColor = [UIColor darkGrayColor];
    mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    [self build];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mainScrollView.frame = CGRectInset(self.view.bounds, 0, 0);
    [self updateFrames];

}
-(void)build{
    
    if (_pages == nil) {
        return;
    }
    for (TopPage *page in _pages) {
        BasePageViewController *baseController = [TopLayoutFactory layoutFromTopPage:page];
        [self addChildViewController:baseController];
        [self.mainScrollView addSubview:baseController.view];
        [baseController didMoveToParentViewController:self];
        [self.controllers addObject:baseController];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)updateFrames{
    CGFloat offsetY = 0;
    for (BasePageViewController *bController in self.controllers) {
        bController.view.frame = CGRectMake(0, offsetY, bController.view.bounds.size.width, bController.view.bounds.size.height);
        offsetY += bController.view.bounds.size.height;
    }
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.bounds.size.width, offsetY);
    _currentPageIndex = 0;
}

-(void)refreshCurrentPage{
    if (_currentPageIndex < self.controllers.count) {
        BasePageViewController *controller = self.controllers[_currentPageIndex];
        [controller refresh];
    }
}
-(BasePageViewController *)currentPageController{
    if (_currentPageIndex >= self.controllers.count) {
        return nil;
    }
    return self.controllers[_currentPageIndex];
}
#pragma mark - scrollview delegate -
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger offsetY = scrollView.contentOffset.y;
    NSInteger height = self.view.bounds.size.height;
    NSInteger page = (offsetY / height);
    if (_currentPageIndex == page) {
        return;
    }
    _currentPageIndex = page;
    if (_currentPageIndex < self.controllers.count) {
        BasePageViewController *controller = self.controllers[_currentPageIndex];
        [controller refresh];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

}
@end
