//
//  SSTThirdViewController.m
//  FullScreen
//
//  Created by Brennan Stehling on 6/14/14.
//  Copyright (c) 2014 SmallSharpTools. All rights reserved.
//

#import "SSTThirdViewController.h"

#import "SSTStyleKit.h"

#define kCutOffPoint 81.0f

#define kTopImageHeight 145.0f

#define kDefineAnimationDuration 0.25f

#define kTagCollectionView 1

#define kTagImageView 1

@interface SSTThirdViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SSTThirdViewController {
    BOOL _topBarsHidden;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.shadowImage = nil;
    [self hideTopBars:FALSE withCompletionBlock:nil];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom = 50.0f;
    self.tableView.contentInset = contentInset;
    
    UIEdgeInsets scrollIndicatorInsets = self.tableView.scrollIndicatorInsets;
    scrollIndicatorInsets.bottom = 50.0f;
    self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return FALSE;
}

#pragma mark - Private
#pragma mark -

- (void)prepareAnimationForNavigationBarWithDuration:(CGFloat)duration {
    // prepare animation for navigation bar
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionFade];
    [self.navigationController.navigationBar.layer addAnimation:animation forKey:nil];
}

- (void)hideTopBars:(BOOL)animated withCompletionBlock:(void (^)())completionBlock {
    // sets a clear background for the top bars
    
    _topBarsHidden = TRUE;
    
    CGFloat duration = animated ? kDefineAnimationDuration : 0.0f;
    
    [self prepareAnimationForNavigationBarWithDuration:duration];
    
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
    } completion:^(BOOL finished) {
        if (finished && completionBlock) {
            completionBlock();
        }
    }];
}

- (void)showTopBars:(BOOL)animated withCompletionBlock:(void (^)())completionBlock {
    // sets the top bars to show an opaque background
    
    _topBarsHidden = FALSE;
    
    CGFloat duration = animated ? kDefineAnimationDuration : 0.0f;
    
    [self prepareAnimationForNavigationBarWithDuration:duration];
    
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        UIImage *backgroundImage = [SSTStyleKit imageOfDarkTopBarBackgroundImage];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    } completion:^(BOOL finished) {
        if (finished && completionBlock) {
            completionBlock();
        }
    }];
}

#pragma mark - User Actions
#pragma mark -

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 21;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TopCellIdentifier = @"TopCell";
    static NSString *BasicCellIdentifier = @"BasicCell";
    
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:TopCellIdentifier forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:BasicCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"Row %li", (long)indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 145.0f;
    }
    else {
        return 44.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %lu", (unsigned long)indexPath.row);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    });
}

#pragma mark - UICollectionViewDataSource
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *PhotoCellIdentifier = @"PhotoCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:kTagImageView];
    NSString *imageName = [NSString stringWithFormat:@"Landscape%lu.jpg", (unsigned long)indexPath.item+1];
    UIImage *image = [UIImage imageNamed:imageName];
    imageView.image = image;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
#pragma mark -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected item %lu", (unsigned long)indexPath.item+1);
}

#pragma mark - UIScrollViewDelegate
#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"offset: %f", scrollView.contentOffset.y);
    
    // adjust the top image view
    CGFloat topImageHeight = kTopImageHeight;
    CGFloat yPos = 0.0f;
    
    if (scrollView.contentOffset.y < 0) {
        topImageHeight += MIN(kTopImageHeight, ABS(scrollView.contentOffset.y));
        yPos += MIN(0, scrollView.contentOffset.y);
    }
    
    UITableViewCell *tableCell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (tableCell) {
        UICollectionView *collectionView = (UICollectionView *)[tableCell viewWithTag:kTagCollectionView];
        if (collectionView) {
            NSArray *indexPaths = [collectionView indexPathsForVisibleItems];
            if (indexPaths.count) {
                UICollectionViewCell *collectionCell = [collectionView cellForItemAtIndexPath:indexPaths[0]];
                if (collectionCell) {
                    UIImageView *imageView = (UIImageView *)[collectionCell viewWithTag:kTagImageView];
                    NSAssert(imageView, @"Image View is required");
                    CGRect frame = imageView.frame;
                    frame.size.height = topImageHeight;
                    frame.origin.y = yPos;
                    imageView.frame = frame;
                    //LOG_FRAME(@"frame", frame);
                }
            }
        }
    }
    
    if (_topBarsHidden && scrollView.contentOffset.y > kCutOffPoint) {
        [self showTopBars:TRUE withCompletionBlock:nil];
    }
    else if (!_topBarsHidden && scrollView.contentOffset.y <= kCutOffPoint) {
        [self hideTopBars:TRUE withCompletionBlock:nil];
    }
}

@end
