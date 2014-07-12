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

#import <UIKit/UIKit.h>

/**
 * @headerfile Violation.h <Violation/Violation.h>
 *
 * The directed press is a continuous gesture. It begins any time a single touch goes down in its view.
 * It is canceled any time a second touch goes down, and it ends whenever the single touch comes up.
 * The target is invoked with the sender in the changed state any time the single touch moves. This gesture
 * recognizer simply allows the caller to track the position of a touch across a view.
 * @code

 - (void)handleDirectedPress:(ViolationDirectedPressGestureRecognizer*)sender
 {
   CGPoint location = [sender locationInView:sender.view];

   switch (sender.state) {
   case UIGestureRecognizerStateBegan:
     // touch down in view, or reentered view after exiting, at location
     break;
   case UIGestureRecognizerStateCancelled:
   case UIGestureRecognizerStateEnded:
     // touch up/cancelled/exited view at location
     break;
   case UIGestureRecognizerStateChanged:
     // touch moved in view to new location
     break;
   default:
     break;
   }
 }

 ViolationDirectedPressGestureRecognizer* directedPressGestureRecognizer = [[ViolationDirectedPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleDirectedPress:)];
   @endcode
 */
@interface ViolationDirectedPressGestureRecognizer : UIGestureRecognizer

@end
