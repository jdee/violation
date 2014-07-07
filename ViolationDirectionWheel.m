/*
 Copyright (c) 2014, Jimmy Dee
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSString+Violation.h"
#import "ViolationDirectedPressGestureRecognizer.h"
#import "ViolationDirectionWheel.h"

@interface ViolationDirectionWheel()
@property (readonly, nonatomic) double fontSizeForTitle;
@property (readonly, nonatomic) double radius;
@end

@implementation ViolationDirectionWheel {
    CALayer* wheelLayer;
}

@dynamic fontSizeForTitle, radius;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        [self addGestureRecognizer:[[ViolationDirectedPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleDirectedPress:)]];
        [self updateImage];

        _lineWidth = 4.0;
        _innerRadius = 0.3 * [self radius];
    }
    return self;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    _isPressed = false;
}

- (void)setInnerRadius:(double)innerRadius
{
    _innerRadius = innerRadius;
    [self updateImage];
}

- (void)setLineWidth:(double)lineWidth
{
    _lineWidth = lineWidth;
    [self updateImage];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self updateImage];
}

- (void)handleDirectedPress:(ViolationDirectedPressGestureRecognizer*)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self updateDirection:sender];
            self.highlighted = YES;
            _isPressed = YES;
            break;
        case UIGestureRecognizerStateChanged:
            [self updateDirection:sender];
            break;
        case UIGestureRecognizerStateEnded:
            _isPressed = NO;
            self.highlighted = NO;
            break;
        case UIGestureRecognizerStateCancelled:
            _isPressed = NO;
            self.highlighted = NO;
            break;
        default:
            break;
    }

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)updateDirection:(ViolationDirectedPressGestureRecognizer*)sender
{
    CGPoint location = [sender locationInView:self];
    double x = location.x - 0.5*self.bounds.size.width;
    double y = 0.5*self.bounds.size.height - location.y;
    _direction = atan2(y, x);
}

- (void)updateImage
{
    [wheelLayer removeFromSuperlayer];

    wheelLayer = [CALayer layer];

    const CGPoint center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);

    // outer ring, tangent to bounds (in square view)
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:self.radius startAngle:0.0 endAngle:2.0*M_PI clockwise:NO].CGPath;
    shapeLayer.lineWidth = _lineWidth;
    shapeLayer.strokeColor = self.currentTitleColor.CGColor;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    [wheelLayer addSublayer:shapeLayer];

    // filled annulus
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:center radius:self.radius-0.5*_lineWidth startAngle:0.0 endAngle:2.0*M_PI clockwise:NO];
    [path addArcWithCenter:center radius:_innerRadius startAngle:0.0 endAngle:2.0*M_PI clockwise:YES];

    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = self.currentFillColor.CGColor;

    [wheelLayer addSublayer:shapeLayer];

    // inner ring
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:self.radius*0.3 startAngle:0.0 endAngle:2.0*M_PI clockwise:YES].CGPath;
    shapeLayer.lineWidth = _lineWidth;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = self.currentTitleColor.CGColor;

    [wheelLayer addSublayer:shapeLayer];

    const double ringThickness = self.radius - _innerRadius;

    const double outerTriangleDistance = self.radius - 0.25 * ringThickness;
    const double innerTriangleDistance = _innerRadius + 0.25 * ringThickness;
    const double triangleHeight = outerTriangleDistance - innerTriangleDistance;
    const double tanPiOver6 = tan(M_PI/6);

    // north
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center.x, center.y-outerTriangleDistance)];
    [path addLineToPoint:CGPointMake(center.x-triangleHeight*tanPiOver6, center.y-innerTriangleDistance)];
    [path addLineToPoint:CGPointMake(center.x+triangleHeight*tanPiOver6, center.y-innerTriangleDistance)];

    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = self.currentTitleColor.CGColor;

    [wheelLayer addSublayer:shapeLayer];

    // south
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center.x, center.y+outerTriangleDistance)];
    [path addLineToPoint:CGPointMake(center.x-triangleHeight*tanPiOver6, center.y+innerTriangleDistance)];
    [path addLineToPoint:CGPointMake(center.x+triangleHeight*tanPiOver6, center.y+innerTriangleDistance)];

    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = self.currentTitleColor.CGColor;

    [wheelLayer addSublayer:shapeLayer];

    // east
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center.x+outerTriangleDistance, center.y)];
    [path addLineToPoint:CGPointMake(center.x+innerTriangleDistance, center.y-tanPiOver6*triangleHeight)];
    [path addLineToPoint:CGPointMake(center.x+innerTriangleDistance, center.y+tanPiOver6*triangleHeight)];

    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = self.currentTitleColor.CGColor;

    [wheelLayer addSublayer:shapeLayer];

    // west
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center.x-outerTriangleDistance, center.y)];
    [path addLineToPoint:CGPointMake(center.x-innerTriangleDistance, center.y-tanPiOver6*triangleHeight)];
    [path addLineToPoint:CGPointMake(center.x-innerTriangleDistance, center.y+tanPiOver6*triangleHeight)];

    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = self.currentTitleColor.CGColor;

    [wheelLayer addSublayer:shapeLayer];

    // optional title
    if (_title) {
        CATextLayer* titleLayer = [CATextLayer layer];
        titleLayer.string = _title;
        titleLayer.alignmentMode = kCAAlignmentCenter;
        titleLayer.fontSize = self.fontSizeForTitle;
        titleLayer.backgroundColor = [UIColor clearColor].CGColor;
        titleLayer.foregroundColor = self.currentTitleColor.CGColor;
        titleLayer.opaque = NO;

        UIFont* font = [UIFont fontWithName:@"Helvetica" size:titleLayer.fontSize];
        CGRect frame;
        frame.size = [_title sizeOfTextWithFont:font];
        frame.origin.x = center.x - 0.5*frame.size.width;
        frame.origin.y = center.y - 0.5*frame.size.height;
        titleLayer.frame = frame;

        [wheelLayer addSublayer:titleLayer];
    }

    [self.layer addSublayer:wheelLayer];
}

- (double)radius
{
    return 0.5*(MIN(self.bounds.size.width, self.bounds.size.height) - _lineWidth);
}

- (double)availableWidthWithTitleSize:(CGSize)titleSize
{
    /*
     * DEBT: The height of the text rectangle depends on the font size. A tiny font will have a wider area
     * available than a huge one.
     */
    const double pad = 0.0;
    const double innerWidth = 2.0*_innerRadius-_lineWidth;
    const double titleHeight = titleSize.height;

    return sqrt(innerWidth*innerWidth - titleHeight*titleHeight) - pad;
}

- (double)fontSizeForTitle
{
    // for the given title string, determine the size of the largest font that will fit it into the title space
    CGFloat fontSize = 0.0;
    CGFloat fontSizes[] = { 36.0, 24.0, 18.0, 14.0, 12.0, 10.0, 9.0 };

    int index;
    for (index=0; index<sizeof(fontSizes)/sizeof(CGFloat); ++index) {
        fontSize = fontSizes[index];
        UIFont* font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        const CGSize size = [_title sizeOfTextWithFont:font];
        const double available = [self availableWidthWithTitleSize:size];
        if (size.width <= available) break;
    }

    return fontSize;
}

@end
