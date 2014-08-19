/*
 Violation
 Copyright (c) 2014, Jimmy Dee
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ViolationGearButton.h"

@implementation ViolationGearButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numTeeth = 8;
        _rotation = 0.0;
        _innerRingRatio = 0.18;
        _innerToothRatio = 0.25;
        _outerToothRatio = 0.3;
        _lineWidth = 1.0;
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self drawGearPath:context];

    CGContextSetLineWidth(context, _lineWidth);
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    CGContextSetStrokeColorWithColor(context, self.currentTitleColor.CGColor);
    CGContextSetShouldAntialias(context, true);
    CGContextStrokePath(context);

    if (_innerRingRatio <= 0.0) return;

    const CGFloat width = self.bounds.size.width;
    const CGFloat height = self.bounds.size.height;
    CGContextAddArc(context, 0.5*width, 0.5*height, _innerRingRatio*MIN(width, height), 0, 2.0*M_PI, NO);
    CGContextStrokePath(context);
}

- (void)drawGearPath:(CGContextRef)context
{
    const CGFloat width = self.bounds.size.width;
    const CGFloat height = self.bounds.size.height;

    const CGFloat dimension = MIN(width, height);

    const CGFloat deltaTheta = 2.0 * M_PI / (CGFloat)_numTeeth;

    CGFloat theta = -0.125 * deltaTheta + _rotation;
    CGFloat radius = _outerToothRatio * dimension;

    CGContextMoveToPoint(context, 0.5*width + cos(theta)*radius, 0.5*height + sin(theta)*radius);

    for (int j=0; j<_numTeeth; ++j) {
        theta = ((CGFloat)j - 0.125) * deltaTheta + _rotation;
        radius = _outerToothRatio * dimension;

        CGContextAddArc(context, 0.5 * width, 0.5 * height, radius, theta, theta + 0.25 * deltaTheta, NO);

        theta += 0.5 * deltaTheta;
        radius = _innerToothRatio * dimension;

        CGContextAddLineToPoint(context, cos(theta)*radius + 0.5 * width, sin(theta)*radius + 0.5 * height);
        CGContextAddArc(context, 0.5 * width, 0.5 * height, radius, theta, theta + 0.25 * deltaTheta, NO);

        theta += 0.5 * deltaTheta;
        radius = _outerToothRatio * dimension;

        CGContextAddLineToPoint(context, cos(theta)*radius + 0.5 * width, sin(theta)*radius + 0.5 * height);
    }

    CGContextAddArc(context, 0.5 * width, 0.5 * height, radius, theta, theta + 0.25 * deltaTheta, NO);
}

@end
