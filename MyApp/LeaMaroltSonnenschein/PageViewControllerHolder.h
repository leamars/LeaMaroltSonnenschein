//
//  PageViewControllerHolder.h
//  LeaMaroltSonnenschein
//
//  Created by Lea Marolt on 4/13/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewControllerHolder : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageActions;
@property (nonatomic, strong) NSArray *pageColors;
@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSArray *nextPageColors;
@property (strong, nonatomic) IBOutlet UIView *holderBackgroundView;
@property (nonatomic) CGFloat lastContentOffset;
@property (strong, nonatomic) IBOutlet UIView *holderSecondBackgroundView;
@property (strong, nonatomic) IBOutlet UIView *testView;
@property (nonatomic, strong) NSArray *bottomActions;


// ACTIONS
- (IBAction)foldView:(id)sender;
- (IBAction)closeView:(id)sender;
- (IBAction)defoldView:(id)sender;
- (IBAction)startViews:(id)sender;


// BUTTONS
@property (strong, nonatomic) IBOutlet UIButton *foldBtn;
@property (strong, nonatomic) IBOutlet UIButton *exitBtn;
@property (strong, nonatomic) IBOutlet UIButton *forwardBtn;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@end
