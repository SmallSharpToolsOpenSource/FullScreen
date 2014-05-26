//
//  SSTClearTopBarsViewController.m
//  FullScreen
//
//  Created by Brennan Stehling on 5/25/14.
//  Copyright (c) 2014 SmallSharpTools. All rights reserved.
//

#import "SSTClearTopBarsViewController.h"

#import "SSTStyleKit.h"

#define kCutOffPoint 81.0f

@interface SSTClearTopBarsViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SSTClearTopBarsViewController {
    BOOL _topBarsClear;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.shadowImage = nil;
    [self hideTopBars:FALSE withCompletionBlock:nil];
    
    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonTapped:)];
    self.navigationItem.leftBarButtonItem = backBarItem;
    
    UILabel *label = (UILabel *)[self.scrollView viewWithTag:1];
    label.text = @"Aesthetic Marfa Shoreditch tattooed tousled meh. Flexitarian mustache put a bird on it, Austin trust fund brunch locavore Echo Park tattooed synth Neutra. Mlkshk tote bag squid, direct trade occupy swag Tumblr dreamcatcher pug. Church-key YOLO Wes Anderson mixtape chambray retro. Forage raw denim normcore, art party pop-up aesthetic cred selvage shabby chic. Slow-carb Pitchfork 3 wolf moon bespoke semiotics squid synth XOXO. Gastropub Kickstarter mlkshk pug, Brooklyn hoodie yr semiotics.\n\nEnnui beard ugh, banh mi post-ironic jean shorts pickled dreamcatcher you probably haven't heard of them McSweeney's raw denim roof party flexitarian ethnic whatever. Neutra wayfarers deep v scenester polaroid. Kogi roof party scenester asymmetrical Schlitz. Fashion axe squid Bushwick letterpress chambray. Kitsch 3 wolf moon sriracha Banksy asymmetrical. Austin literally mumblecore, beard pug VHS tousled you probably haven't heard of them selfies Helvetica quinoa Brooklyn ugh hashtag. Chillwave roof party raw denim pickled.\n\nSustainable flexitarian narwhal, readymade salvia Neutra kitsch raw denim. You probably haven't heard of them photo booth beard Portland normcore umami. Authentic polaroid ethnic, photo booth next level roof party vegan pickled High Life gluten-free pork belly. Forage pop-up tofu, art party iPhone pug four loko cornhole vinyl. Four loko meh bitters, master cleanse you probably haven't heard of them tousled Intelligentsia Carles trust fund farm-to-table asymmetrical normcore narwhal flannel. Literally High Life tofu shabby chic, selfies food truck kale chips blog cred freegan forage Cosby sweater Carles. Artisan food truck ugh authentic cred.";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return FALSE;
}

#pragma mark - Private
#pragma mark -

- (void)hideTopBars:(BOOL)animated withCompletionBlock:(void (^)())completionBlock {
    // sets a clear background for the top bars
    
    _topBarsClear = TRUE;
    
    CGFloat duration = animated ? 0.25f : 0.0f;
    
    [CATransaction setCompletionBlock:completionBlock];
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionFade];
    
    [self.navigationController.navigationBar.layer addAnimation:animation forKey:nil];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    [UIView commitAnimations];
}

- (void)showTopBars:(BOOL)animated withCompletionBlock:(void (^)())completionBlock {
    // sets the top bars to show an opaque background
    
    _topBarsClear = FALSE;
    
    CGFloat duration = animated ? 0.25f : 0.0f;

    CATransition *animation = [CATransition animation];
    [CATransaction setCompletionBlock:completionBlock];
    [animation setDuration:duration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionFade];
    
    [self.navigationController.navigationBar.layer addAnimation:animation forKey:nil];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    
    UIImage *backgroundImage = [SSTStyleKit imageOfBlueTopBarBackgroundImage];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [UIView commitAnimations];
}

#pragma mark - User Actions
#pragma mark -

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)toggleButtonTapped:(id)sender {
    if (_topBarsClear) {
        [self showTopBars:TRUE withCompletionBlock:nil];
    }
    else {
        [self hideTopBars:TRUE withCompletionBlock:nil];
    }
}

#pragma mark - UIScrollViewDelegate
#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"offset: %f", scrollView.contentOffset.y);
    
    if (_topBarsClear) {
        if (scrollView.contentOffset.y > kCutOffPoint) {
            [self showTopBars:TRUE withCompletionBlock:nil];
        }
    }
    else {
        if (scrollView.contentOffset.y <= kCutOffPoint) {
            [self hideTopBars:TRUE withCompletionBlock:nil];
        }
    }
}

@end
