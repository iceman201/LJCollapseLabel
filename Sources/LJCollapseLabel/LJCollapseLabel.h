//
//  LJCollapseLabel.h
//  CollapseLabel
//
//  Created by Liguo Jiao on 11/11/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJCollapseLabel : UILabel


@property (nonatomic, copy) void(^textHeightChangedCallback)(void);
@property (nonatomic) BOOL isCollapsed;
@property (nonatomic, weak) UIFont * _Nullable labelFont;
@property (nonatomic, weak) UIFont * _Nullable buttonFont;
@property (nonatomic) CGFloat minimumHeight;
@property (nonatomic, strong) NSString *collapseButtonTitle;
@property (nonatomic, strong) NSString *expandButtonTitle;

- (void)hideExtraContent;
- (void)setMinimumHeight:(CGFloat)minimumHeight;
- (void)setGradientBackgroundColor:(UIColor *)endColor fadeColor:(UIColor *)startColor;
- (void)setGradientBackgroundColor:(UIColor *)endColor fadeColor:(UIColor *)startColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
