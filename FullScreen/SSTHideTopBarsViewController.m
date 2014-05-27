//
//  SSTViewController.m
//  FullScreen
//
//  Created by Brennan Stehling on 5/25/14.
//  Copyright (c) 2014 SmallSharpTools. All rights reserved.
//

#import "SSTHideTopBarsViewController.h"

#import "SSTStyleKit.h"

#define kCutOffPoint 0.0f

#define kDefineAnimationDuration 0.25f

@interface SSTHideTopBarsViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation SSTHideTopBarsViewController {
    BOOL _showTopView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self hideTopView:FALSE withCompletionBlock:nil];
    
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = 50.0f;
    self.scrollView.contentInset = contentInset;
    
    UIEdgeInsets scrollIndicatorInsets = self.scrollView.scrollIndicatorInsets;
    scrollIndicatorInsets.bottom = 50.0f;
    self.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
    
    UILabel *label = (UILabel *)[self.scrollView viewWithTag:1];
    label.text = @"Aesthetic Marfa Shoreditch tattooed tousled meh. Flexitarian mustache put a bird on it, Austin trust fund brunch locavore Echo Park tattooed synth Neutra. Mlkshk tote bag squid, direct trade occupy swag Tumblr dreamcatcher pug. Church-key YOLO Wes Anderson mixtape chambray retro. Forage raw denim normcore, art party pop-up aesthetic cred selvage shabby chic. Slow-carb Pitchfork 3 wolf moon bespoke semiotics squid synth XOXO. Gastropub Kickstarter mlkshk pug, Brooklyn hoodie yr semiotics.\n\nEnnui beard ugh, banh mi post-ironic jean shorts pickled dreamcatcher you probably haven't heard of them McSweeney's raw denim roof party flexitarian ethnic whatever. Neutra wayfarers deep v scenester polaroid. Kogi roof party scenester asymmetrical Schlitz. Fashion axe squid Bushwick letterpress chambray. Kitsch 3 wolf moon sriracha Banksy asymmetrical. Austin literally mumblecore, beard pug VHS tousled you probably haven't heard of them selfies Helvetica quinoa Brooklyn ugh hashtag. Chillwave roof party raw denim pickled.\n\nSustainable flexitarian narwhal, readymade salvia Neutra kitsch raw denim. You probably haven't heard of them photo booth beard Portland normcore umami. Authentic polaroid ethnic, photo booth next level roof party vegan pickled High Life gluten-free pork belly. Forage pop-up tofu, art party iPhone pug four loko cornhole vinyl. Four loko meh bitters, master cleanse you probably haven't heard of them tousled Intelligentsia Carles trust fund farm-to-table asymmetrical normcore narwhal flannel. Literally High Life tofu shabby chic, selfies food truck kale chips blog cred freegan forage Cosby sweater Carles. Artisan food truck ugh authentic cred.";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return _showTopView;
}

#pragma mark - Private
#pragma mark -

- (void)hideTopView:(BOOL)animated withCompletionBlock:(void (^)())completionBlock {
    // shows the status and navigation bar and hides custom top view
    
    CGFloat duration = animated ? kDefineAnimationDuration : 0.0f;
    
    _showTopView = FALSE;
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
        [self.navigationController setNavigationBarHidden:FALSE animated:TRUE];
        [self setNeedsStatusBarAppearanceUpdate];
        self.topView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished && completionBlock) {
            completionBlock();
        }
    }];
}

- (void)showTopView:(BOOL)animated withCompletionBlock:(void (^)())completionBlock {
    // hides the status and navigation bar and shows custom top view
    
    CGFloat duration = animated ? kDefineAnimationDuration : 0.0f;
    
    _showTopView = TRUE;
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
        [self.navigationController setNavigationBarHidden:TRUE animated:TRUE];
        [self setNeedsStatusBarAppearanceUpdate];
        self.topView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        if (finished && completionBlock) {
            completionBlock();
        }
    }];
}

#pragma mark - User Actions
#pragma mark -

- (IBAction)toggleButtonTapped:(id)sender {
    if (self.navigationController.navigationBar.hidden) {
        [self hideTopView:TRUE withCompletionBlock:nil];
    }
    else {
        [self showTopView:TRUE withCompletionBlock:nil];
    }
}

#pragma mark - UIScrollViewDelegate
#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"offset: %f", scrollView.contentOffset.y);
    
    if (!self.navigationController.navigationBar.hidden) {
        if (scrollView.contentOffset.y > kCutOffPoint) {
            [self showTopView:TRUE withCompletionBlock:nil];
        }
    }
    else {
        if (scrollView.contentOffset.y <= kCutOffPoint) {
            [self hideTopView:TRUE withCompletionBlock:nil];
        }
    }
}

@end
