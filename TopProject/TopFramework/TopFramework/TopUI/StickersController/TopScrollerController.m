//
//  TopScrollerController.m
//  TopFramework
//
//  Created by Makeitapp USA on 19/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopScrollerController.h"

@interface TopScrollerController ()<UIScrollViewDelegate>{
    UIViewController *_currentController;
}

@property (nonatomic,strong) NSArray <TopScrollerBaseLayout *> *scrollerLayoutControllers;

@end

@implementation TopScrollerController
- (instancetype)initWithScrollerLayouts:(NSArray <TopScrollerBaseLayout *>*)scrollerLayoutControlles
{
    self = [super init];
    if (self) {
        _scrollerLayoutControllers = scrollerLayoutControlles;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self buildScrollerController];
}

- (void)buildScrollerController{
    UIScrollView *mainScroller = [[UIScrollView alloc]initWithFrame:CGRectInset(self.view.bounds, 10,10)];
    mainScroller.backgroundColor = [UIColor greenColor];
    [self.view addSubview:mainScroller];
    
    CGFloat maxContentWidth = 0;
    CGSize scrollerControllerSize = CGSizeMake(mainScroller.bounds.size.width, mainScroller.bounds.size.height);
    
    for (TopScrollerBaseLayout *controller in self.scrollerLayoutControllers) {
        [self addChildViewController:controller];
        controller.view.frame = CGRectMake(maxContentWidth, 0, scrollerControllerSize.width, scrollerControllerSize.height);
        controller.view.backgroundColor = [UIColor yellowColor];
        [mainScroller addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        maxContentWidth += controller.view.bounds.size.width;
    }
    
    mainScroller.contentSize = CGSizeMake(maxContentWidth, mainScroller.bounds.size.height);
    mainScroller.pagingEnabled = YES;
}

- (UIViewController *)currentController{
    
    return nil;
}
#pragma mark - privates -
- (void)scrollToScrollerLayout:(UIViewController *)scrollerLayoutController{
    
}

#pragma mark - scrollView delegates -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

@end
