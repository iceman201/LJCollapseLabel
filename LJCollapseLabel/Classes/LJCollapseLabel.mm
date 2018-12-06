//
//  LJCollapseLabel.m
//  CollapseLabel
//
//  Created by Liguo Jiao on 11/11/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "LJCollapseLabel.h"
#import "GradientBackgroundView.h"

@interface LJCollapseLabel()

@property (nonatomic, strong) GradientBackgroundView *gradientBackground;
@property (nonatomic, weak) UIButton *collapseButton;
@property (nonatomic, strong) UILabel *expandLabel;
@property (nonatomic) NSInteger contentLines;
@property (nonatomic) BOOL shouldShowCollapse;
@property (nonatomic) NSLayoutConstraint *heightConstrain;

@end

@implementation LJCollapseLabel
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _isCollapsed = NO;
    _shouldShowCollapse = NO;
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILabel *extra = [[UILabel alloc] init];
    [extra setText:@"more"];
    extra.font = self.labelFont;
    extra.textColor = [UIColor blackColor];
    extra.hidden = YES;
    extra.textAlignment = NSTextAlignmentRight;
    
    UIButton *collapse = [[UIButton alloc] init];
    collapse.titleLabel.font = self.buttonFont;
    collapse.hidden = YES;
    [collapse setTitle:@"Collapse" forState:UIControlStateNormal];
    [collapse setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [collapse addTarget:self action:@selector(hideExtraContent) forControlEvents:UIControlEventTouchUpInside];
    
    GradientBackgroundView *gradient = [[GradientBackgroundView alloc] init];
    gradient.startColor = [UIColor colorWithWhite:1 alpha:0];
    gradient.endColor = [UIColor whiteColor];
    gradient.startPoint = CGPointMake(0.0, 1.0);
    gradient.endPoint = CGPointMake(0.35, 1.0);
    gradient.hidden = YES;
    _gradientBackground = gradient;
    _expandLabel = extra;
    _collapseButton = collapse;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showExtraContent)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
    
    [self addSubview:_gradientBackground];
    [self addSubview:_expandLabel];
    [self addSubview:_collapseButton];
    
    [self.expandLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.expandLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-8] setActive:YES];
    [[self.expandLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-1] setActive:YES];
    
    [self.collapseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.collapseButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0] setActive:YES];
    [[self.collapseButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0] setActive:YES];
    
    [self.gradientBackground setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.gradientBackground.widthAnchor constraintEqualToAnchor:self.expandLabel.widthAnchor multiplier:2.5 constant:-2.5] setActive:YES];
    [[self.gradientBackground.heightAnchor constraintEqualToAnchor:self.expandLabel.heightAnchor multiplier:1 constant:1] setActive:YES];

    [[self.gradientBackground.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0] setActive:YES];
    [[self.gradientBackground.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0] setActive:YES];
    [[self.gradientBackground.widthAnchor constraintGreaterThanOrEqualToConstant:12] setActive:YES];
    [[self.gradientBackground.heightAnchor constraintGreaterThanOrEqualToConstant:30] setActive:YES];

    _expandLabel.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
}

- (void)showExtraContent
{
    _isCollapsed = NO;
    [self.heightConstrain setActive:NO];
    
    [self setNeedsLayout];
    
    if (self.textHeightChangedCallback)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.textHeightChangedCallback();
        });
    }
}

- (void)hideExtraContent
{
    _isCollapsed = YES;
    [self.heightConstrain setActive:YES];
    [self setNeedsLayout];
    
    if (self.textHeightChangedCallback)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.textHeightChangedCallback();
        });
    }
}

- (void)setMinimumHeight:(CGFloat)minimumHeight
{
    CGFloat actualHeight = self.font.pointSize*(self.numberOfLines + 1);
    if (actualHeight < minimumHeight) {
        self.heightConstrain = [self.heightAnchor constraintEqualToConstant:minimumHeight];
    } else {
        self.heightConstrain = [self.heightAnchor constraintEqualToConstant:actualHeight];

    }
    [self.heightConstrain setActive:YES];
    [self layoutIfNeeded];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self layoutIfNeeded];
    [self bringSubviewToFront:_gradientBackground];
    [self bringSubviewToFront:_expandLabel];
}

- (void)setNumberOfLines:(NSInteger)numberOfLines
{
    [super setNumberOfLines:numberOfLines];
    if (numberOfLines != 0)
    {
        _contentLines = numberOfLines;
        _isCollapsed = YES;
    }
}

- (void)setExpandButtonTitle:(NSString *)expandButtonTitle
{
    self.expandLabel.text = expandButtonTitle;
}

- (void)setCollapseButtonTitle:(NSString *)collapseButtonTitle
{
    [self.collapseButton setTitle:collapseButtonTitle forState:UIControlStateNormal];
}

- (void)setGradientBackgroundColor:(UIColor *)endColor fadeColor:(UIColor *)startColor
{
    self.gradientBackground.startColor = startColor;
    self.gradientBackground.endColor = endColor;
}

- (void)setGradientBackgroundColor:(UIColor *)endColor fadeColor:(UIColor *)startColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    [self setGradientBackgroundColor:endColor fadeColor:startColor];
    self.gradientBackground.startPoint = startPoint;
    self.gradientBackground.endPoint = endPoint;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_isCollapsed)
    {
        // NumberOfLine default to 0 is using for extend out all the content.
        self.numberOfLines = 0;
        NSInteger lineCount = 0;
        CGSize textSize = CGSizeMake(self.bounds.size.width, MAXFLOAT);
        long rHeight = lroundf([self sizeThatFits:textSize].height);
        long charSize = lroundf(1.0); //self.lineHeight
        lineCount = rHeight/charSize;
        
        if (lineCount <= _contentLines)
        {
            self.numberOfLines = 0;
            [self setComponentHidden:YES];
            _collapseButton.hidden = YES;
            [self setShouldShowCollapse:NO];
        }
        else
        {
            self.numberOfLines = _contentLines;
            [self setComponentHidden:NO];
            [self setShouldShowCollapse:YES];
        }
    }
    else
    {
        self.numberOfLines = 0;
        [self setComponentHidden:YES];
    }
}

- (void)setComponentHidden:(BOOL)display
{
    _expandLabel.hidden = display;
    _gradientBackground.hidden = display;
    _collapseButton.hidden = _shouldShowCollapse ? !display : YES;
}

- (void)setShouldShowCollapse:(BOOL)shouldShowCollapse
{
    _shouldShowCollapse = shouldShowCollapse;
    self.text = [self.text stringByReplacingOccurrencesOfString:@"\n\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(self.text.length-4,4)];
    if (shouldShowCollapse)
    {
        self.text = [NSString stringWithFormat:@"%@\n\n", self.text];
    }
}

@end
