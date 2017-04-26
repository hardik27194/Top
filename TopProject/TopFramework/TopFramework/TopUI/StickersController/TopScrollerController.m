//
//  TopScrollerController.m
//  TopFramework
//
//  Created by Makeitapp USA on 19/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopScrollerController.h"
#import "TopScrollerBaseLayout.h"

@interface TopScrollerController ()<UIScrollViewDelegate>{
    UIViewController *_currentController;
    NSInteger _currentPageIndex;

}

@property (nonatomic,strong) NSArray <TopScrollerBaseLayout *> *scrollerLayoutControllers;
@property (nonatomic,weak) UIScrollView *mainScroller;

@end

@implementation TopScrollerController
@synthesize stickerControllerDelegate;

- (instancetype)initWithScrollerLayouts:(NSArray *)scrollerLayoutControlles
{
    self = [super init];
    if (self) {
        _scrollerLayoutControllers = scrollerLayoutControlles;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [TopStyleUtils colorFromHexString:@"efefef" withAlpha:1];
    _currentPageIndex = 0;
   [self buildScrollerController];
}

- (void)buildScrollerController{
    UIScrollView *mainScroller = [[UIScrollView alloc]initWithFrame:CGRectInset(self.view.bounds, 10,10)];
    mainScroller.backgroundColor = [UIColor greenColor];
    mainScroller.delegate = self;
    [self.view addSubview:mainScroller];
    self.mainScroller = mainScroller;
    
    
    for (TopScrollerBaseLayout *controller in self.scrollerLayoutControllers) {
        [self addChildViewController:controller];
        controller.view.backgroundColor = [UIColor yellowColor];
        [mainScroller addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
    
    mainScroller.pagingEnabled = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mainScroller.frame = CGRectInset(self.view.bounds, 10,10);
    CGSize scrollerControllerSize = CGSizeMake(self.mainScroller.bounds.size.width, self.mainScroller.bounds.size.height);
    CGFloat maxContentWidth = 0;
    for (TopScrollerBaseLayout *controller in self.scrollerLayoutControllers) {
        controller.view.frame = CGRectMake(maxContentWidth, 0, scrollerControllerSize.width, scrollerControllerSize.height);
        maxContentWidth += controller.view.bounds.size.width;
    }
    self.mainScroller.contentSize = CGSizeMake(maxContentWidth, self.mainScroller.bounds.size.height);
 
    [self enumCurrentControllers:^(UIViewController *controller) {
        if ([controller respondsToSelector:@selector(refresh)]) {
            [controller performSelector:@selector(refresh) withObject:nil afterDelay:0];
        }
    }];
    
}

#pragma mark - get controllers -
- (UIViewController *)currentController{
    if (_currentPageIndex >= self.scrollerLayoutControllers.count) {
        return nil;
    }
    return [self.scrollerLayoutControllers[_currentPageIndex] currentPageController];
}
-(NSArray *)currentControllers{
    if (_currentPageIndex >= self.scrollerLayoutControllers.count) {
        return nil;
    }
    NSMutableArray *controllers = [[NSMutableArray alloc]init];
    UIViewController *cController = [self.scrollerLayoutControllers[_currentPageIndex] currentPageController];
    UIViewController *nController = [self.scrollerLayoutControllers[_currentPageIndex] nextPageController];
    UIViewController *pController = [self.scrollerLayoutControllers[_currentPageIndex] previousPageController];
    if (controllers) {
        [controllers addObject:cController];
    }
    if (nController) {
        [controllers addObject:nController];
    }
    if (pController) {
        [controllers addObject:pController];
    }
    return (NSArray *)controllers;
}

#pragma mark - privates -

- (void)enumCurrentControllers:(void(^)(UIViewController *controller))controllersBlock{
    for (UIViewController *controller in [self currentControllers]) {
        controllersBlock(controller);
    }
}
- (void)scrollToScrollerLayout:(UIViewController *)scrollerLayoutController{
    
}

#pragma mark - scrollView delegates -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger offsetX = scrollView.contentOffset.x;
    NSInteger width = scrollView.bounds.size.width;
    NSInteger page = (offsetX / width);
    if (_currentPageIndex == page) {
        return;
    }
    _currentPageIndex = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.stickerControllerDelegate askRefreshFromStickerController:self];
}

@end
