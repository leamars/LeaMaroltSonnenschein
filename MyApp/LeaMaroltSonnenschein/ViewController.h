//
//  ViewController.h
//  LeaMaroltSonnenschein
//
//  Created by Lea Marolt on 4/13/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *circleView;
@property (strong, nonatomic) IBOutlet UIImageView *leaImageView;
@property (strong, nonatomic) IBOutlet UILabel *helloLabel;
@property (strong, nonatomic) IBOutlet UILabel *introLabel;
@property (strong, nonatomic) IBOutlet UIView *backgroundTop;
@property (strong, nonatomic) IBOutlet UIView *informationView;
@property (strong, nonatomic) IBOutlet UIView *informationViewHolder;


// PAGE VIEW CONTROLLER
@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) NSString *bottomAction;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic) CGFloat viewOffset;
@property (nonatomic, strong) UIImage *pageImage;

// INSIDE VIEW
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

