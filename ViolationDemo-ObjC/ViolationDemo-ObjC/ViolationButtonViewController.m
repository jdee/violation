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
#import "IOSKnobControl.h"
#import "ViolationButtonViewController.h"

@interface ViolationButtonViewController ()
@property (nonatomic) IOSKnobControl* teethKnob;
@property (nonatomic) IOSKnobControl* rotationKnob;
@property (nonatomic) ViolationGearButton* button;

@end

@implementation ViolationButtonViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupTabBarItem];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupTabBarItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.tabBarController.tabBar respondsToSelector:@selector(setTranslucent:)]) {
        self.tabBarController.tabBar.translucent = NO;
    }

    _button = [[ViolationGearButton alloc] initWithFrame: _buttonHolder.bounds];
    _button.numTeeth = 10;
    _button.lineWidth = 2;
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

    [_buttonHolder addSubview:_button];

    _teethKnob = [[IOSKnobControl alloc] initWithFrame:_teethKnobHolder.bounds];
    _teethKnob.mode = IKCModeLinearReturn;
    _teethKnob.positions = 7;
    _teethKnob.titles = @[ @"6", @"7", @"8", @"9", @"10", @"11", @"12" ];
    _teethKnob.positionIndex = 4; // starts at 10
    [_teethKnob addTarget:self action:@selector(numTeethChanged:) forControlEvents:UIControlEventValueChanged];
    [_teethKnob setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_teethKnobHolder addSubview:_teethKnob];

    _rotationKnob = [[IOSKnobControl alloc] initWithFrame:_rotationKnobHolder.bounds];
    _rotationKnob.mode = IKCModeContinuous;
    _rotationKnob.circular = YES;
    _rotationKnob.normalized = YES;
    _rotationKnob.clockwise = NO;
    [_rotationKnob addTarget:self action:@selector(rotationChanged:) forControlEvents:UIControlEventValueChanged];
    [_rotationKnob setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rotationKnobHolder addSubview:_rotationKnob];

    ViolationGearBarButtonItem* buttonItem = [[ViolationGearBarButtonItem alloc] initWithTarget:self action:@selector(toolbarButtonPressed:)];
    buttonItem.button.numTeeth = 8;
    buttonItem.button.lineWidth = 1;
    buttonItem.button.rotation = M_PI/8;
    [buttonItem.button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [buttonItem.button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    _toolbar.items = @[ buttonItem ];
}

- (void)innerRingRatioChanged:(UISlider *)sender
{
    _button.innerRingRatio = sender.value;
}

- (void)innerToothRatioChanged:(UISlider *)sender
{
    _button.innerToothRatio = sender.value;
}

- (void)numTeethChanged:(IOSKnobControl*)sender
{
    _button.numTeeth = 6 + sender.positionIndex;
}

- (void)rotationChanged:(IOSKnobControl*)sender
{
    _button.rotation = sender.position;
}

- (void)toolbarButtonPressed:(ViolationGearBarButtonItem*)sender
{
}

- (void)setupTabBarItem
{
    ViolationGearButton* dummy = [[ViolationGearButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    dummy.numTeeth = 10;
    dummy.lineWidth = 1;
    dummy.innerRingRatio = 0;

    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Button" image:dummy.image tag:2];
}

@end
