//
//  PageViewControllerHolder.m
//  LeaMaroltSonnenschein
//
//  Created by Lea Marolt on 4/13/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "PageViewControllerHolder.h"
#import "ViewController.h"

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

@interface PageViewControllerHolder ()

@end

@implementation PageViewControllerHolder {
    CGFloat offset;
    NSUInteger pageIndex;
    ViewController *currentViewController;
    BOOL scrolledForward;
    int someIndex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.pageActions = @[@"PERSONAL", @"DEVELOPMENT", @"DESIGN", @"EXTRAVAGANZA"];
    
    self.bottomActions = @[@"My name is Lea!", @"I like to make stuff.", @"I like to make it pretty.", @"Find me on the web."];
    
    self.pageColors = @[[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:71.0/255.0 alpha:1], [UIColor colorWithRed:21.0/255.0 green:71.0/255.0 blue:61.0/255.0 alpha:1], [UIColor colorWithRed:71.0/255.0 green:21.0/255.0 blue:49.0/255.0 alpha:1]];
    
    self.pageImages = @[@"leaPhoto", @"Develop", @"Design", @"Interests", @"Web"];
    
    // PAGE VIEW CONTROLLER
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    //NSLog(@"Data source is: %@", self.infoPageViewController)
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    ViewController *startingViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(10, 0, self.view.frame.size.width - 50, self.view.frame.size.height);
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    __weak UIPageViewController * _weakPageViewController = self.pageViewController;
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES completion:^(BOOL finished) {
                                           UIPageViewController* pvcs = _weakPageViewController;
                                           if (!pvcs) return;
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [pvcs setViewControllers:viewControllers
                                                              direction:UIPageViewControllerNavigationDirectionForward
                                                               animated:NO completion:nil];
                                           });
                                       }];
    someIndex = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Page View Controller Methods

- (IBAction)startWalkthrough {
    ViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    [self viewDidLoad];
}

- (ViewController *) viewControllerAtIndex:(NSUInteger) index {
    if (([self.pageActions count] == 0) || (index >= [self.pageActions count])) {
        return nil;
    }
    
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewControllerContent"];
    
    vc.action = self.pageActions[index];
    //    pvch.imageFile = self.pageImages[index];
    vc.pageIndex = index;
    
    for (UIView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setDelegate:self];
        }
    }
    
    UIImage *pageImg = [UIImage imageNamed:self.pageImages[index]];
    vc.pageImage = pageImg;
    vc.bottomAction = self.bottomActions[index];
    
    currentViewController = vc;
    
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    scrolledForward = NO;
    
    NSUInteger index = ((ViewController *) viewController).pageIndex;
    pageIndex = index;
    
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    
    index--;

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    scrolledForward = YES;
    
    NSUInteger index = ((ViewController *) viewController).pageIndex;
    pageIndex = index;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [self.pageActions count]) {
        return [self viewControllerAtIndex:0];
    }
    
    return [self viewControllerAtIndex:index];
}

// present the dots

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pageActions count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    self.holderBackgroundView.backgroundColor = self.pageColors[pageIndex];
}



-(CGFloat)getPercentageFromOffset:(CGFloat) theOffset {
    // starts from 320, ends at 640
    
    CGFloat percentageValue = (theOffset+360)/1000;
    
    return percentageValue;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    offset = scrollView.contentOffset.x / (SCREEN_WIDTH-50) - 1;
    CGFloat transitionWithOpacity;
    if (offset < 0) {
        transitionWithOpacity = offset * (-1);
    }
    else {
        transitionWithOpacity = offset;
    }

    [self.holderBackgroundView setAlpha:fabs(1-transitionWithOpacity)];
    
    if (pageIndex > [self.pageColors count] - 1) {
        pageIndex = 0;
    }

    self.holderSecondBackgroundView.backgroundColor = self.pageColors[pageIndex];

}

- (IBAction)foldView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"foldViewThingForward" object:nil];
}

- (IBAction)closeView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeViewThing" object:nil];
    self.foldBtn.backgroundColor = [UIColor clearColor];
}

- (IBAction)defoldView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"foldViewThingBackward" object:nil];
}

- (IBAction)startViews:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playViewThing" object:nil];
}

@end
