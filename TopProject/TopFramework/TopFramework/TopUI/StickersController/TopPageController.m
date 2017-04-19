//
//  NewViewController.m
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 26/06/14.
//  Copyright (c) 2014 Jacopo. All rights reserved.
//

#import "TopPageController.h"
@interface TopPageController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    NSArray *controllers;
    BOOL pageAnimationFinished;
    UIViewController *_currentController;
}
@property (nonatomic,strong) UIPageViewController *pageController;
@property (nonatomic,strong) NSArray *pages;


@end

@implementation TopPageController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (instancetype)initWithPages:(NSArray *)pages
{
    self = [super init];
    if (self) {
        _pages = [[NSArray alloc]initWithArray:pages];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];

    [self buildPageController];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    for (UIViewController *controller in self.pages) {
        if ([controller respondsToSelector:@selector(refresh)]) {
            [controller performSelector:@selector(refresh) withObject:nil afterDelay:0];
        }
    }
}
- (void)buildPageController
{

    self.pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    pageAnimationFinished = YES;
    
    
    _currentController = self.pages[0];

    [self.pageController setViewControllers:[NSArray arrayWithObject:_currentController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
    self.pageController.doubleSided = NO;
   
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
   // self.view.gestureRecognizers = self.pageController.gestureRecognizers;
    self.view.gestureRecognizers = self.pageController.gestureRecognizers;
    
    // Find the tap gesture recognizer so we can remove it!
    UIGestureRecognizer* tapRecognizer = nil;
    for (UIGestureRecognizer* recognizer in self.pageController.gestureRecognizers) {
        if ( [recognizer isKindOfClass:[UITapGestureRecognizer class]] ) {
            tapRecognizer = recognizer;
            break;
        }
    }
    
    if ( tapRecognizer ) {
        [self.view removeGestureRecognizer:tapRecognizer];
        [self.pageController.view removeGestureRecognizer:tapRecognizer];
    }
}
- (UIViewController *)currentController{
    return _currentController;
}
#pragma mark - page controller delegate -

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (pageAnimationFinished) {
        
        NSUInteger index = [self.pages indexOfObject:viewController];
        
        index--;
        
        if (index == -1) {
            return nil;
        }
        
    
        return [self.pages objectAtIndex:index];
    }
    else return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    if (pageAnimationFinished) {
        
        NSUInteger index = [self.pages indexOfObject:viewController];
        
        index++;
        if (index >= self.pages.count) {
            return nil;
        }
        return [self.pages objectAtIndex:index];
        
    }
    else return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    pageAnimationFinished = YES;
    _currentController = pageViewController.viewControllers[0];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    pageAnimationFinished = NO;
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
        [pageViewController setViewControllers:@[[self.pageController.viewControllers objectAtIndex:0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
        pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;

}
@end
