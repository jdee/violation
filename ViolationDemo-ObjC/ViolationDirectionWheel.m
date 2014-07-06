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
    UIControlEvents eventsToSend = 0;

    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self updateDirection:sender];
            _isPressed = YES;
            eventsToSend = UIControlEventTouchDown | UIControlEventValueChanged;
            break;
        case UIGestureRecognizerStateChanged:
            [self updateDirection:sender];
            eventsToSend = UIControlEventTouchDragInside | UIControlEventValueChanged;
            break;
        case UIGestureRecognizerStateEnded:
            eventsToSend = UIControlEventTouchUpInside | UIControlEventValueChanged;
            _isPressed = NO;
            break;
        case UIGestureRecognizerStateCancelled:
            eventsToSend = UIControlEventTouchCancel | UIControlEventValueChanged;
            _isPressed = NO;
            break;
        default:
            break;
    }

    [self sendActionsForControlEvents:eventsToSend];
}

- (void)updateDirection:(ViolationDirectedPressGestureRecognizer*)sender
{
    CGPoint location = [sender locationInView:self];
    double x = location.x - 0.5*self.bounds.size.width;
    double y = 0.5*self.bounds.size.height - location.y;
    _direction = atan2(y, x);
}

@end
