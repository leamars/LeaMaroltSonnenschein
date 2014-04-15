//
//  ViewController.m
//  LeaMaroltSonnenschein
//
//  Created by Lea Marolt on 4/13/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "ViewController.h"
#import "PageViewControllerHolder.h"
#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

{
    int someIndex;
    BOOL playBtnClicked;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.circleView.alpha = 0.75;
    self.circleView.layer.cornerRadius = self.circleView.frame.size.width/2;
    self.circleView.backgroundColor = [UIColor whiteColor];
    
    self.leaImageView.layer.cornerRadius = self.leaImageView.frame.size.width/2;
    self.leaImageView.image = self.pageImage;
    self.leaImageView.layer.masksToBounds = YES;
    self.leaImageView.alpha = 1;
    
    self.helloLabel.text = self.action;
    [self.helloLabel setFont:[UIFont fontWithName:@"QuattrocentoSans-Bold" size:20]];
    self.helloLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    
    self.introLabel.text = self.bottomAction;
    self.introLabel.textAlignment = NSTextAlignmentCenter;
    [self.introLabel setFont:[UIFont fontWithName:@"QuattrocentoSans-Bold" size:20]];
    self.introLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    
    self.helloLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    self.helloLabel.shadowOffset = CGSizeMake(0, 1);
    
    self.introLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    self.introLabel.shadowOffset = CGSizeMake(0, 1);
    
    //[self animateWithUIColor:[UIColor grayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playViewThing) name:@"playViewThing" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(foldViewThingForward) name:@"foldViewThingForward" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(foldViewThingBackward) name:@"foldViewThingBackward" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeViewThing) name:@"closeViewThing" object:nil];

}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.informationView.alpha = 0;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
}

- (void) animateWithUIColor:(UIColor *)color {
    [UIView animateWithDuration:1.0 animations:^{
        self.view.backgroundColor = color;
    }];

}

- (UIView *)getLabelForIndex:(NSUInteger)index
{
	self.informationView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.informationView sizeToFit];
	[self.titleLabel setFont:[UIFont fontWithName:@"QuattrocentoSans" size:20]];
	[self.titleLabel setTextColor:[UIColor darkGrayColor]];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    int switchPage = 0;
    
    if ([self.helloLabel.text isEqualToString:@"DEVELOPMENT"]) {
        switchPage = 1;
    }
    else if ([self.helloLabel.text isEqualToString:@"DESIGN"]) {
        switchPage = 2;
    }
    else if ([self.helloLabel.text isEqualToString:@"EXTRAVAGANZA"]) {
        switchPage = 3;
    }
    
    if (switchPage == 0) {
        switch (index) {
            case 0:
                self.titleLabel.text = [NSString stringWithFormat:@"I come a tiny little country called Slovenia. It's shaped like a chicken."];
                self.imageView.image = [UIImage imageNamed:@"Slovenia"];
                break;
                
            case 1:
                self.titleLabel.text = [NSString stringWithFormat:@"I'm 21 years of age and am currently pursuing Computer Science and Studio Art majors at Grinnell College."];
                self.imageView.image = [UIImage imageNamed:@"GrinnellCollege"];
                break;
                
            case 2:
                self.titleLabel.text = [NSString stringWithFormat:@"I play the piano. I pretend I know how to bake. I never go anywhere without headphones. I speak 5 language."];
                self.imageView.image = [UIImage imageNamed:@"World"];
                break;
        }
    }
    
    if (switchPage == 1) {
        switch (index) {
            case 0:
                self.titleLabel.text = [NSString stringWithFormat:@"I co-founded Grinnell AppDev. It's a student group devoted to producing quality mobile applications on the iOS and Android platform."];
                self.imageView.image = [UIImage imageNamed:@"AppDev"];
                break;
                
            case 1:
                self.titleLabel.text = [NSString stringWithFormat:@"I started and organized Pioneer Weekend, a startup-weekend like event at the college with funding from the Wilson Program."];
                self.imageView.image = [UIImage imageNamed:@"Pioneer"];
                break;
                
            case 2:
                self.titleLabel.text = [NSString stringWithFormat:@"I created Remember, a simple mobile application geared towards the elderly that helps them train their memory."];
                self.imageView.image = [UIImage imageNamed:@"RememberShot"];
                break;
                
            case 3:
                self.titleLabel.text = [NSString stringWithFormat:@"Under AppDev I completely redesigned and redeveloped our S&B where you can read the articles from the Scarlet & Black."];
                self.imageView.image = [UIImage imageNamed:@"SANDB"];
                break;
                
            case 4:
                self.titleLabel.text = [NSString stringWithFormat:@"On my first ever hackathon I developed a crowdsourcing story-telling mobile application called Scripts."];
                self.imageView.image = [UIImage imageNamed:@"Scripts"];
                break;
                
            case 5:
                self.titleLabel.text = [NSString stringWithFormat:@"Developed an API to interact between the Ushahidi client and Android SDK as part of a research project during summer 2013."];
                self.imageView.image = [UIImage imageNamed:@"Ushahidi"];
                break;
            default:
                break;
        }
    }
    
    if (switchPage == 2) {
        switch (index) {
            case 0:
                self.titleLabel.text = [NSString stringWithFormat:@"Developed and designed the website for Voyse - a mobile application that lets you send encrypted voice messages that get erased when they're heard."];
                self.imageView.image = [UIImage imageNamed:@"Voyse"];
                break;
                
            case 1:
                self.titleLabel.text = [NSString stringWithFormat:@"Designed the content for FaceTag - a mobile version of the popular assassin game."];
                self.imageView.image = [UIImage imageNamed:@"FaceTag"];
                break;
                
            case 2:
                self.titleLabel.text = [NSString stringWithFormat:@"Designed and developed the informational website for Grinnell AppDev."];
                self.imageView.image = [UIImage imageNamed:@"AppDevWeb"];
                break;
                
            case 3:
                self.titleLabel.text = [NSString stringWithFormat:@"Painted a fractal image on a 40x40 inch canvas based on a program we had to write in CS 151 for GIMP in Scheme."];
                self.imageView.image = [UIImage imageNamed:@"Fractal"];
                break;
                
            default:
                break;
        }
    }
    
        if (switchPage == 3) {
            switch (index) {
                case 0:
                    self.titleLabel.text = [NSString stringWithFormat:@"I'm very proud of my curated 8tracks' playlists. Listen to my jams by looking up @hellosunschein."];
                    self.imageView.image = [UIImage imageNamed:@"8tracks"];
                    break;
                    
                case 1:
                    self.titleLabel.text = [NSString stringWithFormat:@"Check out my personal website, where I keep track of my current projects and development/design resources. hellosunschein.com"];
                    self.imageView.image = [UIImage imageNamed:@"Hellosunschein"];
                    break;
                    
                case 2:
                    self.titleLabel.text = [NSString stringWithFormat:@"Find out more about my professional background by going to - linkedin.com/in/leamarolt"];
                    self.imageView.image = [UIImage imageNamed:@"LinkedIn"];
                    break;
                    
                case 3:
                    self.titleLabel.text = [NSString stringWithFormat:@"I attended and presented at the SIGCSE conference in Atlanta & the Grace Hopper Celebration of Women in Computing on a scholarship."];
                    self.imageView.image = [UIImage imageNamed:@"Sigcse"];
                    break;
                    
                case 4:
                    self.titleLabel.text = [NSString stringWithFormat:@"I love going to hackathons and was one of the very few females that presented hack at the first MHacks."];
                    self.imageView.image = [UIImage imageNamed:@"Mhacks"];
                    break;
                    
                case 5:
                    self.titleLabel.text = [NSString stringWithFormat:@"That's all. Hope you enjoyed my app. Hasta la vista!"];
                    self.imageView.image = [UIImage imageNamed:@"Wink"];
                    break;
                    
                default:
                    break;
            }
        }
    
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.informationView.alpha = 1;
    }];
    
	return self.informationView;
}

-(void) foldViewThingForward {
    if (playBtnClicked) {
        someIndex++;
        [self getLabelForIndex:someIndex];
    }
}

-(void) foldViewThingBackward {
    if(playBtnClicked) {
        someIndex--;
        [self getLabelForIndex:someIndex];
    }
}

-(void) closeViewThing {
    
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.informationView.alpha = 0;
    }];
}

-(void) playViewThing {
    playBtnClicked = YES;
    someIndex = 0;
    [self getLabelForIndex:someIndex];
}


@end
