//
//  SSTStyleKit.m
//  FullScreen
//
//  Created by FullScreen on 5/26/14.
//  Copyright (c) 2014 FullScreen. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "SSTStyleKit.h"


@implementation SSTStyleKit

#pragma mark Cache

static UIColor* _myBlueColor = nil;
static UIColor* _myShadowGradientClearColor = nil;
static UIColor* _myShadowGradientBlackColor = nil;

static PCGradient* _myShadowGradient = nil;

static UIImage* _imageOfClearTopBarBackgroundImage = nil;
static UIImage* _imageOfBlueTopBarBackgroundImage = nil;
static UIImage* _imageOfTopShadow = nil;

#pragma mark Initialization

+ (void)initialize
{
    // Colors Initialization
    _myBlueColor = [UIColor colorWithRed: 0 green: 0 blue: 0.251 alpha: 1];
    _myShadowGradientClearColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0];
    _myShadowGradientBlackColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.5];

    // Gradients Initialization
    CGFloat myShadowGradientLocations[] = {0, 0.75, 1};
    _myShadowGradient = [PCGradient gradientWithColors: @[SSTStyleKit.myShadowGradientBlackColor, [UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 0.25], SSTStyleKit.myShadowGradientClearColor] locations: myShadowGradientLocations];

}

#pragma mark Colors

+ (UIColor*)myBlueColor { return _myBlueColor; }
+ (UIColor*)myShadowGradientClearColor { return _myShadowGradientClearColor; }
+ (UIColor*)myShadowGradientBlackColor { return _myShadowGradientBlackColor; }

#pragma mark Gradients

+ (PCGradient*)myShadowGradient { return _myShadowGradient; }

#pragma mark Drawing Methods

+ (void)drawClearTopBarBackgroundImage;
{

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 100)];
    [UIColor.clearColor setFill];
    [rectanglePath fill];
}

+ (void)drawBlueTopBarBackgroundImage;
{

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 100)];
    [SSTStyleKit.myBlueColor setFill];
    [rectanglePath fill];
}

+ (void)drawTopShadow;
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 60)];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, SSTStyleKit.myShadowGradient.CGGradient, CGPointMake(160, -0), CGPointMake(160, 60), 0);
    CGContextRestoreGState(context);
}

#pragma mark Generated Images

+ (UIImage*)imageOfClearTopBarBackgroundImage;
{
    if (_imageOfClearTopBarBackgroundImage)
        return _imageOfClearTopBarBackgroundImage;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 100), NO, 0.0f);
    [SSTStyleKit drawClearTopBarBackgroundImage];
    _imageOfClearTopBarBackgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfClearTopBarBackgroundImage;
}

+ (UIImage*)imageOfBlueTopBarBackgroundImage;
{
    if (_imageOfBlueTopBarBackgroundImage)
        return _imageOfBlueTopBarBackgroundImage;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 100), NO, 0.0f);
    [SSTStyleKit drawBlueTopBarBackgroundImage];
    _imageOfBlueTopBarBackgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfBlueTopBarBackgroundImage;
}

+ (UIImage*)imageOfTopShadow;
{
    if (_imageOfTopShadow)
        return _imageOfTopShadow;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 60), NO, 0.0f);
    [SSTStyleKit drawTopShadow];
    _imageOfTopShadow = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfTopShadow;
}

#pragma mark Customization Infrastructure

- (void)setClearTopBarBackgroundImageTargets: (NSArray*)clearTopBarBackgroundImageTargets
{
    _clearTopBarBackgroundImageTargets = clearTopBarBackgroundImageTargets;

    for (id target in self.clearTopBarBackgroundImageTargets)
        [target setImage: SSTStyleKit.imageOfClearTopBarBackgroundImage];
}

- (void)setBlueTopBarBackgroundImageTargets: (NSArray*)blueTopBarBackgroundImageTargets
{
    _blueTopBarBackgroundImageTargets = blueTopBarBackgroundImageTargets;

    for (id target in self.blueTopBarBackgroundImageTargets)
        [target setImage: SSTStyleKit.imageOfBlueTopBarBackgroundImage];
}

- (void)setTopShadowTargets: (NSArray*)topShadowTargets
{
    _topShadowTargets = topShadowTargets;

    for (id target in self.topShadowTargets)
        [target setImage: SSTStyleKit.imageOfTopShadow];
}


@end



@interface PCGradient ()
{
    CGGradientRef _CGGradient;
}
@end

@implementation PCGradient

- (instancetype)initWithColors: (NSArray*)colors locations: (const CGFloat*)locations
{
    self = super.init;
    if (self)
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        NSMutableArray* cgColors = NSMutableArray.array;
        for (UIColor* color in colors)
            [cgColors addObject: (id)color.CGColor];

        _CGGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)cgColors, locations);
        CGColorSpaceRelease(colorSpace);
    }
    return self;
}

+ (instancetype)gradientWithColors: (NSArray*)colors locations: (const CGFloat*)locations
{
    return [self.alloc initWithColors: colors locations: locations];
}

+ (instancetype)gradientWithStartingColor: (UIColor*)startingColor endingColor: (UIColor*)endingColor
{
    CGFloat locations[] = {0, 1};
    return [self.alloc initWithColors: @[startingColor, endingColor] locations: locations];
}

- (void)dealloc
{
    CGGradientRelease(_CGGradient);
}

@end
