/*
 Copyright (c) 2014, Jimmy Dee
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#import <UIKit/UIGestureRecognizerSubclass.h>

#import <Violation/Violation.h>
#import <XCTest/XCTest.h>

@interface ViolationDirectedPressGestureRecognizerTests : XCTestCase {
    ViolationDirectedPressGestureRecognizer* gestureRecognizer;
}

@end

@implementation ViolationDirectedPressGestureRecognizerTests

- (void)setUp {
    [super setUp];

    gestureRecognizer = [[ViolationDirectedPressGestureRecognizer alloc] initWithTarget:nil action:nil];
}

- (void)testGestureBegin {
    UITouch* firstTouch = [[UITouch alloc] init];

    NSSet* oneTouch = [NSSet setWithObject:firstTouch];

    [gestureRecognizer touchesBegan:oneTouch withEvent:nil];
    XCTAssertEqual(UIGestureRecognizerStateBegan, gestureRecognizer.state, @"gesture recognizer should be in began state");
}

- (void)testGestureFail {
    UITouch* firstTouch = [[UITouch alloc] init];
    UITouch* secondTouch = [[UITouch alloc] init];

    NSSet* multipleTouches = [NSSet setWithObjects:firstTouch, secondTouch, nil];
    [gestureRecognizer touchesBegan:multipleTouches withEvent:nil];
    XCTAssertEqual(UIGestureRecognizerStateFailed, gestureRecognizer.state, @"gesture recognizer should be in failed state with multiple touches");
}

- (void)testGestureChanged {
    /*
     * Have to mock the position in a view, which the GR doesn't currently have.
     */
}

- (void)testGestureEnd {
    UITouch* firstTouch = [[UITouch alloc] init];

    NSSet* oneTouch = [NSSet setWithObject:firstTouch];

    [gestureRecognizer touchesEnded:oneTouch withEvent:nil];
    XCTAssertEqual(UIGestureRecognizerStateEnded, gestureRecognizer.state, @"gesture recognizer should be in ended state");
}

@end
