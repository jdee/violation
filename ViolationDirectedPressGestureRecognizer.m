//
//  LAPressGestureRecognizer.m
//  Laertes
//
//  Created by Jimmy Dee on 4/30/13.
//  Copyright (c) 2013 Jimmy Dee. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>

#import "ViolationDirectedPressGestureRecognizer.h"

@interface ViolationDirectedPressGestureRecognizer()
@property SEL action;
@property id target;
- (void) notifyClient;
@end

@implementation ViolationDirectedPressGestureRecognizer
@synthesize target, action;

- (id)initWithTarget:(id)aTarget action:(SEL)anAction
{
    self = [super initWithTarget:aTarget action:anAction];
    if (self) {
        action = anAction;
        target = aTarget;
    }
    return self;
}

/*
 * DEBT: Isn't this handled by the base class?
 */
- (void)notifyClient
{
    if (action && target && [target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:action withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
    self.state = UIGestureRecognizerStateChanged;
    [self notifyClient];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateEnded;
    [self notifyClient];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateCancelled;
    [self notifyClient];
}

- (void)reset
{
    self.state = UIGestureRecognizerStatePossible;
}

- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event
{
    
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return YES;
}

@end
