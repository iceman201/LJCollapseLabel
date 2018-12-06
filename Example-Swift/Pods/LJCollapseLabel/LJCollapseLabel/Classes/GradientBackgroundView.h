//
//  GradientBackgroundView.m
//  CollapseLabel
//
//  Created by Liguo Jiao on 11/11/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>

enum GradientDirection
{
    TOP_TO_BOTTOM,
    LEFT_TO_RIGHT,
    TOP_LEFT_TO_BOTTOM_RIGHT,
    TOP_RIGHT_TO_BOTTOM_LEFT,
};

@interface GradientBackgroundView : UIView

@property (weak, nonatomic, readonly) CAGradientLayer *gradientLayer;

@property (nonatomic) IBInspectable CGPoint startPoint;
@property (nonatomic) IBInspectable CGPoint endPoint;

@property (strong, nonatomic) UIColor *startColor;
@property (strong, nonatomic) UIColor *endColor;

- (void)setStartColor:(UIColor *)startColor endColor:(UIColor *)endColor direction:(enum GradientDirection)direction;
- (void)gradientToTransparentFromColor:(UIColor *)startColor direction:(enum GradientDirection)direction;

@end
