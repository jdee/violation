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

@implementation ViolationDirectionWheel

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
{    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self updateDirection:sender];
            _isPressed = YES;
            break;
        case UIGestureRecognizerStateChanged:
            [self updateDirection:sender];
            break;
        case UIGestureRecognizerStateEnded:
            _isPressed = NO;
            break;
        case UIGestureRecognizerStateCancelled:
            _isPressed = NO;
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

- (void)drawWheel
{
    const double lineWidth = 4.0;
    const double radius = 0.5*(MIN(self.bounds.size.width, self.bounds.size.height) - lineWidth);
    const CGPoint center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);

    // outer ring, tangent to bounds (in square view)
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0.0 endAngle:2.0*M_PI clockwise:NO].CGPath;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    [self.layer addSublayer:shapeLayer];

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
    shapeLayer.fillColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;

    [self.layer addSublayer:shapeLayer];

    // inner ring
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius*0.3 startAngle:0.0 endAngle:2.0*M_PI clockwise:YES].CGPath;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.frame = self.bounds;
    shapeLayer.opaque = NO;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;

    [self.layer addSublayer:shapeLayer];

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
    shapeLayer.fillColor = [UIColor blackColor].CGColor;

    [self.layer addSublayer:shapeLayer];

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
    shapeLayer.fillColor = [UIColor blackColor].CGColor;

    [self.layer addSublayer:shapeLayer];

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
    shapeLayer.fillColor = [UIColor blackColor].CGColor;

    [self.layer addSublayer:shapeLayer];

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
    shapeLayer.fillColor = [UIColor blackColor].CGColor;

    [self.layer addSublayer:shapeLayer];
}

@end
