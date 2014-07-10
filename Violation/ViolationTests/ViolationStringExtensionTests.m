/*
 Copyright (c) 2014, Jimmy Dee
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <XCTest/XCTest.h>
#import "NSString+Violation.h"

@interface ViolationStringExtensionTests : XCTestCase

@end

@implementation ViolationStringExtensionTests

- (void)testMethodAvailability {
    /*
     * It's hard to test this for two reasons.
     * 1. It's a version-portability mechanism. It distinguishes versions of iOS, in effect, by checking for the
     * presence of a selector introduced in iOS 7. It's hard to add and remove that selector from the NSString class
     * at runtime to actually exercise the code in NSString+Violation.m. At best we can test that the string responds
     * to the new selector, sizeOfTextWithFont:.
     * 2. It's hard to run this test. It seems that the test target for a framework does not produce an executable
     * binary. The simulator has nothing to run. So for now the tests live in ViolationDemo-ObjCTests, and only
     * the public parts of the framework can be tested. I have no desire to provide this little version-portability
     * extension as a public feature of Violation, so it can't be tested there.
     *
     * Maybe the second problem can be overcome.
     */
    NSString* s = @"hello";
    XCTAssertTrue([s respondsToSelector:@selector(sizeOfTextWithFont:)], @"should respondToSelector: sizeOfTextWithFont:");
}

@end
