//
//  GradientBackgroundView.m
//  CollapseLabel
//
//  Created by Liguo Jiao on 11/11/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "GradientBackgroundView.h"

@interface GradientBackgroundView ()

@end

@implementation GradientBackgroundView

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self updateLayerFrame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateLayerFrame];
}

- (void)updateLayerFrame
{
    CAAnimation *animation = [self.layer animationForKey:self.layer.animationKeys.firstObject];
    
    if (animation)
    {
        [CATransaction begin];
        [CATransaction setAnimationDuration:animation.duration];
        [CATransaction setAnimationTimingFunction:animation.timingFunction];
        
        self.gradientLayer.frame = self.bounds;
        
        [CATransaction commit];
    }
    else
    {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.gradientLayer.frame = self.bounds;
        [CATransaction commit];
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10.0, 10.0)];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    masklayer.path = path.CGPath;
    masklayer.backgroundColor = [[UIColor redColor] CGColor];
    
    self.layer.mask = masklayer;
}

@synthesize gradientLayer = _gradientLayer;
- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer)
    {
        CAGradientLayer *layer = [CAGradientLayer layer];

        layer.frame = self.bounds;
        layer.locations = @[@0, @1];

        
        [self.layer insertSublayer:layer atIndex:0];
        _gradientLayer = layer;
    }
    return _gradientLayer;
}

- (CGPoint)startPoint
{
    return self.gradientLayer.startPoint;
}

- (void)setStartPoint:(CGPoint)startPoint
{
    self.gradientLayer.startPoint = startPoint;
}

- (CGPoint)endPoint
{
    return self.gradientLayer.endPoint;
}
- (void)setEndPoint:(CGPoint)endPoint
{
    self.gradientLayer.endPoint = endPoint;
}

- (void)setStartColor:(UIColor *)startColor
{
    _startColor = startColor;
    if (_startColor != nil && _endColor != nil)
    {
        self.gradientLayer.colors = @[(id) _startColor.CGColor, (id) _endColor.CGColor];
    }
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
    if (_startColor != nil && _endColor != nil)
    {
        self.gradientLayer.colors = @[(id) _startColor.CGColor, (id) _endColor.CGColor];
    }
}

- (void)setStartColor:(UIColor *)startColor endColor:(UIColor *)endColor direction:(enum GradientDirection)direction
{
    self.startColor = startColor;
    self.endColor = endColor;
    
    switch (direction)
    {
        case TOP_TO_BOTTOM:
            self.startPoint = CGPointMake(0.5, 0);
            self.endPoint = CGPointMake(0.5, 1);
            break;
        case LEFT_TO_RIGHT:
            self.startPoint = CGPointMake(0, 0.5);
            self.endPoint = CGPointMake(1, 0.5);
            break;
        case TOP_LEFT_TO_BOTTOM_RIGHT:
            self.startPoint = CGPointMake(0, 0);
            self.endPoint = CGPointMake(1, 1);
            break;
        case TOP_RIGHT_TO_BOTTOM_LEFT:
            self.startPoint = CGPointMake(1, 0);
            self.endPoint = CGPointMake(0, 1);
            break;
    }
}

- (void)gradientToTransparentFromColor:(UIColor *)startColor direction:(enum GradientDirection)direction
{
    [self setStartColor:startColor endColor:[startColor colorWithAlphaComponent:0] direction:direction];
}

@end
