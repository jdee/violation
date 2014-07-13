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

@import Violation;

#import "ViolationGestureViewController.h"

@implementation ViolationGestureViewController {
    UIImageView* star;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ViolationDirectedPressGestureRecognizer* directedPressGestureRecognizer = [[ViolationDirectedPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleDirectedPress:)];
    [_input addGestureRecognizer:directedPressGestureRecognizer];

    star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hammer_sickle_in_star"]];
    star.hidden = YES;
    [_output addSubview:star];
}

- (void)handleDirectedPress:(ViolationDirectedPressGestureRecognizer*)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self setStarFrame:sender];
            star.hidden = NO;
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            star.hidden = YES;
            break;
        case UIGestureRecognizerStateChanged:
            [self setStarFrame:sender];
            break;
        default:
            break;
    }
}

- (void)setStarFrame:(ViolationDirectedPressGestureRecognizer*)sender
{
    CGPoint location = [sender locationInView:_input];
    CGRect frame = star.frame;
    frame.origin.x = location.x - frame.size.width * 0.5;
    frame.origin.y = location.y - frame.size.height * 0.5;
    star.frame = frame;
}

@end
