/*
 Copyright (c) 2014, Jimmy Dee
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ViolationDirectedPressGestureRecognizer.h"
#import "ViolationDirectionWheel.h"

@implementation ViolationDirectionWheel {
    UIColor* fillColor[4], *titleColor[4];
    CALayer* wheelLayer;
}

@dynamic currentFillColor, currentTitleColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer:[[ViolationDirectedPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleDirectedPress:)]];
        [self drawWheel];
    }
    return self;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    _isPressed = false;
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

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self drawWheel];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self drawWheel];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self drawWheel];
}

- (UIColor *)currentTitleColor
{
    return [self titleColorForState:self.state];
}

- (UIColor *)currentFillColor
{
    return [self fillColorForState:self.state];
}

/*
 * Private method used by imageForState: and setImage:forState:.
 * For a pure state (only one bit set) other than normal, returns that bit + 1. If no
 * bits set, returns 0. If more than one bit set, returns the
 * index corresponding to the highest bit. So for state == UIControlStateNormal,
 * returns 0. For state == UIControlStateDisabled, returns 2. For
 * state == UIControlStateDisabled | UIControlStateSelected, returns 3.
 * Does not currently support UIControlStateApplication. Returns -1 if those bits are set.
 */
- (int)indexForState:(UIControlState)state
{
    if ((state & UIControlStateApplication) != 0) return -1;
    if ((state & UIControlStateSelected) != 0) return 3;
    if ((state & UIControlStateDisabled) != 0) return 2;
    if ((state & UIControlStateHighlighted) != 0) return 1;
    return 0;
}

- (UIColor *)fillColorForState:(UIControlState)state
{
    int index = [self indexForState:state];
    // NSLog(@"state index: %d", index);
    UIColor* color = index >= 0 && fillColor[index] ? fillColor[index] : fillColor[[self indexForState:UIControlStateNormal]];
    // NSLog(@"fill color is %snil", color ? "not" : "");

    if (!color) {
        CGFloat red, green, blue, alpha;
        [self.getTintColor getRed:&red green:&green blue:&blue alpha:&alpha];

        CGFloat hue, saturation, brightness;
        [self.getTintColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

        // make the interior be partly transparent by default
        alpha = 0.5;

        if ((red == green && green == blue) || brightness < 0.02) {
            /*
             * This is for any shade of gray from black to white. Unfortunately, black is not really black.
             * It comes out as a red hue. Hence the brightness test above.
             */
            CGFloat value = ((NSNumber*)@[@(0.6), @(0.8), @(0.9), @(0.8)][index]).floatValue;
            color = [UIColor colorWithRed:value green:value blue:value alpha:alpha];
        }
        else {
            saturation = ((NSNumber*)@[@(1.0), @(0.7), @(0.2), @(0.7)][index]).floatValue;
            brightness = ((NSNumber*)@[@(0.9), @(1.0), @(0.9), @(1.0)][index]).floatValue;
            color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
        }
    }

    return color;
}

- (void)setFillColor:(UIColor *)color forState:(UIControlState)state
{
    int index = [self indexForState:state];
    if (state == UIControlStateNormal || state == UIControlStateHighlighted || state == UIControlStateDisabled || state == UIControlStateSelected) {
        fillColor[index] = color;
    }

    if (index == [self indexForState:self.state]) {
        [self drawWheel];
    }
}

- (UIColor *)titleColorForState:(UIControlState)state
{
    int index = [self indexForState:state];
    // NSLog(@"state index: %d", index);
    UIColor* color = index >= 0 && titleColor[index] ? titleColor[index] : titleColor[[self indexForState:UIControlStateNormal]];
    // NSLog(@"title color is %snil", color ? "not" : "");

    if (!color) {
        CGFloat red, green, blue, alpha;
        [self.getTintColor getRed:&red green:&green blue:&blue alpha:&alpha];

        CGFloat hue, saturation, brightness;
        [self.getTintColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

        if ((red == green && green == blue) || brightness < 0.02) {
            /*
             * This is for any shade of gray from black to white. Unfortunately, black is not really black.
             * It comes out as a red hue. Hence the brightness test above.
             */
            CGFloat value = ((NSNumber*)@[@(0.25), @(0.25), @(0.4), @(0.25)][index]).floatValue;
            color = [UIColor colorWithRed:value green:value blue:value alpha:alpha];
        }
        else {
            saturation = ((NSNumber*)@[@(1.0), @(1.0), @(0.2), @(1.0)][index]).floatValue;
            brightness = 0.5; // ((NSNumber*)@[@(0.5), @(0.5), @(0.5), @(0.5)][index]).floatValue;
            color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
        }
    }

    return color;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    int index = [self indexForState:state];
    if (state == UIControlStateNormal || state == UIControlStateHighlighted || state == UIControlStateDisabled || state == UIControlStateSelected) {
        titleColor[index] = color;
    }

    if (index == [self indexForState:self.state]) {
        [self drawWheel];
    }
}

- (UIColor*)getTintColor
{
    /*
     * No tintColor below iOS 7. This simplifies some internal code.
     */
    if ([self respondsToSelector:@selector(tintColor)]) {
        return self.tintColor;
    }

    return [UIColor blueColor];
}

- (void)drawWheel
{
    [wheelLayer removeFromSuperlayer];

    wheelLayer = [CALayer layer];

    const double lineWidth = 4.0;
    const double radius = 0.5*(MIN(self.bounds.size.width, self.bounds.size.height) - lineWidth);
    const CGPoint center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);

    // outer ring, tangent to bounds (in square view)
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0.0 endAngle:2.0*M_PI clockwise:NO].CGPath;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.strokeColor = self.currentTitleColor.CGColor;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    [wheelLayer addSublayer:shapeLayer];

    // filled annulus
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:center radius:radius-0.5*lineWidth startAngle:0.0 endAngle:2.0*M_PI clockwise:NO];
    [path addArcWithCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:radius*0.3 startAngle:0.0 endAngle:2.0*M_PI clockwise:YES];

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
    shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius*0.3 startAngle:0.0 endAngle:2.0*M_PI clockwise:YES].CGPath;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = self.currentTitleColor.CGColor;

    [wheelLayer addSublayer:shapeLayer];

    const double outerTriangleDistance = radius * 0.85;
    const double innerTriangleDistance = radius * 0.45;
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

    [self.layer addSublayer:wheelLayer];
}

@end
