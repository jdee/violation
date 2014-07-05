//
//  SecondViewController.m
//  ViolationDemo-ObjC
//
//  Created by Jimmy Dee on 7/5/14.
//  Copyright (c) 2014 Violation Technology. All rights reserved.
//

@class ViolationDirectedPressGestureRecognizer; // required by the generated -Swift header.
#import "ViolationDemo_ObjC-Swift.h" // generated header to bridge Swift
#import "ViolationControlViewController.h"

@implementation ViolationControlViewController {
    ViolationDirectionWheel* directionWheel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    directionWheel = [[ViolationDirectionWheel alloc] initWithFrame:_controlHolder.bounds];
    [directionWheel addTarget:self action:@selector(somethingChanged:) forControlEvents:UIControlEventValueChanged];
    [_controlHolder addSubview:directionWheel];
}

- (void)somethingChanged:(ViolationDirectionWheel*)sender
{
    _pressedLabel.text = sender.isPressed ? @"pressed" : @"";
    _directionLabel.text = [NSString stringWithFormat:@"%.2f", sender.direction];
}

@end
