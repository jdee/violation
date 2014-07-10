/*
 Copyright (c) 2014, Jimmy Dee
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Violation/Violation.h>
#import <XCTest/XCTest.h>

@interface ViolationDirectionWheelTests : XCTestCase {
    ViolationDirectionWheel* wheel;
    UIImage* wheelImage, *starImage;
}

@end

@implementation ViolationDirectionWheelTests

- (void)setUp {
    wheelImage = [UIImage imageNamed:@"direction-wheel"];
    starImage = [UIImage imageNamed:@"hammer_and_sickle_in_star"];

    wheel = [[ViolationDirectionWheel alloc] initWithFrame:CGRectZero];
}

#pragma mark - Images (base class)

- (void)testDisabledImageHandling {
    // with a normal image and a disabled image, a disabled knob control should use the disabled one.
    [wheel setImage:starImage forState:UIControlStateNormal];
    [wheel setImage:wheelImage forState:UIControlStateDisabled];
    XCTAssertEqual(wheelImage, [wheel imageForState:UIControlStateDisabled], @"wheel should use disabled image in disabled state");

    [wheel setImage:nil forState:UIControlStateDisabled];
    XCTAssertEqual(starImage, [wheel imageForState:UIControlStateDisabled], @"wheel should use normal image in disabled state without a disabled image");
}

- (void)testHighlightedImageHandling {
    // with a normal image and a highlighted image, a highlighted knob control should use the highlighted one.
    [wheel setImage:starImage forState:UIControlStateNormal];
    [wheel setImage:wheelImage forState:UIControlStateHighlighted];
    XCTAssertEqual(wheelImage, [wheel imageForState:UIControlStateHighlighted], @"wheel should use highlighted image in highlighted state");

    [wheel setImage:nil forState:UIControlStateHighlighted];
    XCTAssertEqual(starImage, [wheel imageForState:UIControlStateHighlighted], @"wheel should use normal image in highlighted state without a highlighted image");
}

- (void)testSelectedImageHandling {
    // with a normal image and a selected image, a selected knob control should use the selected one.
    [wheel setImage:starImage forState:UIControlStateNormal];
    [wheel setImage:wheelImage forState:UIControlStateSelected];
    XCTAssertEqual(wheelImage, [wheel imageForState:UIControlStateSelected], @"wheel should use selected image in selected state");

    [wheel setImage:nil forState:UIControlStateSelected];
    XCTAssertEqual(starImage, [wheel imageForState:UIControlStateSelected], @"wheel should use normal image in selected state without a selected image");
}

#pragma mark - Fill Colors (base class)

- (void)testDisabledFillColorHandling {
    // with a normal fill color and a disabled fill color, a disabled knob control should use the disabled one.
    [wheel setFillColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [wheel setFillColor:[UIColor greenColor] forState:UIControlStateDisabled];
    XCTAssertEqual([UIColor greenColor], [wheel fillColorForState:UIControlStateDisabled], @"wheel should use disabled fill color in disabled state");

    [wheel setFillColor:nil forState:UIControlStateDisabled];
    XCTAssertEqual([UIColor yellowColor], [wheel fillColorForState:UIControlStateDisabled], @"wheel should use normal fill color in disabled state without a disabled fill color");
}

- (void)testHighlightedFillColorHandling {
    // with a normal fill color and a highlighted fill color, a highlighted knob control should use the highlighted one.
    [wheel setFillColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [wheel setFillColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    XCTAssertEqual([UIColor greenColor], [wheel fillColorForState:UIControlStateHighlighted], @"wheel should use highlighted fill color in highlighted state");

    [wheel setFillColor:nil forState:UIControlStateHighlighted];
    XCTAssertEqual([UIColor yellowColor], [wheel fillColorForState:UIControlStateHighlighted], @"wheel should use normal fill color in highlighted state without a highlighted fill color");
}

- (void)testSelectedFillColorHandling {
    // with a normal fill color and a disabled fill color, a selected knob control should use the selected one.
    [wheel setFillColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [wheel setFillColor:[UIColor greenColor] forState:UIControlStateSelected];
    XCTAssertEqual([UIColor greenColor], [wheel fillColorForState:UIControlStateSelected], @"wheel should use selected fill color in selected state");

    [wheel setFillColor:nil forState:UIControlStateSelected];
    XCTAssertEqual([UIColor yellowColor], [wheel fillColorForState:UIControlStateSelected], @"wheel should use normal fill color in selected state without a selected fill color");
}

#pragma mark - Title Colors (base class)

- (void)testDisabledTitleColorHandling {
    // with a normal title color and a disabled title color, a disabled knob control should use the disabled one.
    [wheel setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [wheel setTitleColor:[UIColor greenColor] forState:UIControlStateDisabled];
    XCTAssertEqual([UIColor greenColor], [wheel titleColorForState:UIControlStateDisabled], @"wheel should use disabled title color in disabled state");

    [wheel setTitleColor:nil forState:UIControlStateDisabled];
    XCTAssertEqual([UIColor yellowColor], [wheel titleColorForState:UIControlStateDisabled], @"wheel should use normal title color in disabled state without a disabled title color");
}

- (void)testHighlightedTitleColorHandling {
    // with a normal title color and a highlighted title color, a highlighted knob control should use the highlighted one.
    [wheel setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [wheel setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    XCTAssertEqual([UIColor greenColor], [wheel titleColorForState:UIControlStateHighlighted], @"wheel should use highlighted title color in highlighted state");

    [wheel setTitleColor:nil forState:UIControlStateHighlighted];
    XCTAssertEqual([UIColor yellowColor], [wheel titleColorForState:UIControlStateHighlighted], @"wheel should use normal title color in highlighted state without a highlighted title color");
}

- (void)testSelectedTitleColorHandling {
    // with a normal title color and a selected title color, a selected knob control should use the selected one.
    [wheel setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [wheel setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    XCTAssertEqual([UIColor greenColor], [wheel titleColorForState:UIControlStateSelected], @"wheel should use selected title color in selected state");

    [wheel setTitleColor:nil forState:UIControlStateSelected];
    XCTAssertEqual([UIColor yellowColor], [wheel titleColorForState:UIControlStateSelected], @"wheel should use normal title color in selected state without a selected title color");
}

#pragma mark - Titles

- (void)testDisabledTitleHandling {
    // with a normal title and a disabled title, a disabled knob control should use the disabled one.
    [wheel setTitle:@"normal" forState:UIControlStateNormal];
    [wheel setTitle:@"disabled" forState:UIControlStateDisabled];
    XCTAssertEqual(@"disabled", [wheel titleForState:UIControlStateDisabled], @"wheel should use disabled title in disabled state");

    [wheel setTitle:nil forState:UIControlStateDisabled];
    XCTAssertEqual(@"normal", [wheel titleForState:UIControlStateDisabled], @"wheel should use normal title in disabled state without a disabled title");
}

- (void)testHighlightedTitleHandling {
    // with a normal title and a highlighted title, a highlighted knob control should use the highlighted one.
    [wheel setTitle:@"normal" forState:UIControlStateNormal];
    [wheel setTitle:@"highlighted" forState:UIControlStateHighlighted];
    XCTAssertEqual(@"highlighted", [wheel titleForState:UIControlStateHighlighted], @"wheel should use highlighted title in highlighted state");

    [wheel setTitle:nil forState:UIControlStateHighlighted];
    XCTAssertEqual(@"normal", [wheel titleForState:UIControlStateHighlighted], @"wheel should use normal title in highlighted state without a highlighted title");
}

- (void)testSelectedTitleHandling {
    // with a normal title and a selected title, a selected knob control should use the selected one.
    [wheel setTitle:@"normal" forState:UIControlStateNormal];
    [wheel setTitle:@"selected" forState:UIControlStateSelected];
    XCTAssertEqual(@"selected", [wheel titleForState:UIControlStateSelected], @"wheel should use selected title in selected state");

    [wheel setTitle:nil forState:UIControlStateSelected];
    XCTAssertEqual(@"normal", [wheel titleForState:UIControlStateSelected], @"wheel should use normal title in selected state without a selected title");
}

#pragma mark - Title images

- (void)testDisabledTitleImageHandling {
    // with a normal title image and a disabled title image, a disabled knob control should use the disabled one.
    [wheel setTitleImage:starImage forState:UIControlStateNormal];
    [wheel setTitleImage:wheelImage forState:UIControlStateDisabled];
    XCTAssertEqual(wheelImage, [wheel titleImageForState:UIControlStateDisabled], @"wheel should use disabled title image in disabled state");

    [wheel setTitleImage:nil forState:UIControlStateDisabled];
    XCTAssertEqual(starImage, [wheel titleImageForState:UIControlStateDisabled], @"wheel should use normal title image in disabled state without a disabled title image");
}

- (void)testHighlightedTitleImageHandling {
    // with a normal title image and a highlighted title image, a highlighted knob control should use the highlighted one.
    [wheel setTitleImage:starImage forState:UIControlStateNormal];
    [wheel setTitleImage:wheelImage forState:UIControlStateHighlighted];
    XCTAssertEqual(wheelImage, [wheel titleImageForState:UIControlStateHighlighted], @"wheel should use highlighted title image in highlighted state");

    [wheel setTitleImage:nil forState:UIControlStateHighlighted];
    XCTAssertEqual(starImage, [wheel titleImageForState:UIControlStateHighlighted], @"wheel should use normal title image in highlighted state without a highlighted title image");
}

- (void)testSelectedTitleImageHandling {
    // with a normal title image and a selected title image, a selected knob control should use the selected one.
    [wheel setTitleImage:starImage forState:UIControlStateNormal];
    [wheel setTitleImage:wheelImage forState:UIControlStateSelected];
    XCTAssertEqual(wheelImage, [wheel titleImageForState:UIControlStateSelected], @"wheel should use selected title image in selected state");

    [wheel setTitleImage:nil forState:UIControlStateSelected];
    XCTAssertEqual(starImage, [wheel titleImageForState:UIControlStateSelected], @"wheel should use normal title image in selected state without a selected title image");
}

@end
