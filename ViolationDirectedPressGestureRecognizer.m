/*
 Copyright (c) 2014, Jimmy Dee
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * This is mature Obj-C code. I had hoped to rewrite this simple thing in Swift, but this private method business makes it a little more
 * complicated.
 */
#import <UIKit/UIGestureRecognizerSubclass.h>

#import "ViolationDirectedPressGestureRecognizer.h"

@interface ViolationDirectedPressGestureRecognizer()
@property (nonatomic) SEL action;
@property (nonatomic) id target;
@end

@implementation ViolationDirectedPressGestureRecognizer

- (id)initWithTarget:(id)aTarget action:(SEL)anAction
{
    self = [super initWithTarget:aTarget action:anAction];
    if (self) {
        _action = anAction;
        _target = aTarget;
    }
    return self;
}

/*
 * DEBT: Isn't this handled by the base class? How do you make use of additional targets and actions
 * if addTarget:action: is called? For that matter, if I stick with this, I need to override
 * addTarget:action: and removeTarget:action:.
 */
- (void)notifyClient
{
    if (_action && _target && [_target respondsToSelector:_action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_action withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    switch (self.state) {
        case UIGestureRecognizerStatePossible:
            self.state = touches.count == 1 ? UIGestureRecognizerStateBegan : UIGestureRecognizerStateFailed;
            break;
        default:
            self.state = UIGestureRecognizerStateCancelled;
            break;
    }
    
    [self notifyClient];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];

    CGPoint location = [self locationInView:self.view];
    self.state = CGRectContainsPoint(self.view.bounds, location) ? UIGestureRecognizerStateChanged : UIGestureRecognizerStateCancelled;
    [self notifyClient];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.state = UIGestureRecognizerStateEnded;
    [self notifyClient];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateCancelled;
    [self notifyClient];
}

- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event
{
    // NO. :p
    // Or rather, DEBT: Do this.
}

@end
