//
//  SSTBaseNavigationController.m
//  FullScreen
//
//  Created by Brennan Stehling on 5/25/14.
//  Copyright (c) 2014 SmallSharpTools. All rights reserved.
//

#import "SSTBaseNavigationController.h"

@interface SSTBaseNavigationController ()

@end

@implementation SSTBaseNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

@end
