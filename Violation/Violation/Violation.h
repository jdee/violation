/**
 @mainpage Violation for iOS

 https://github.com/jdee/violation

 Violation is a framework for iOS providing UI components including a custom gesture recognizer (@ref ViolationDirectedPressGestureRecognizer)
 and a custom control that uses it (@ref ViolationDirectionWheel). For instructions on using the framework in your build, see README.md.

 Violation
 Copyright (c) 2014, Jimmy Dee
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#if !__has_feature(objc_arc)
#error Violation requires automatic reference counting.
#endif // objc_arc

#import <UIKit/UIKit.h>

/*
 * If using a version of Xcode below 6, which is required to build Violation as a framework, #define VIOLATION_NO_FRAMEWORK.
 * This will let you simply insert the source code for Violation into your project and #import <Violation/Violation.h>
 * normally. These version numbers will not be available.
 */
#ifndef VIOLATION_NO_FRAMEWORK
//! Project version number for Violation.
FOUNDATION_EXPORT double ViolationVersionNumber;

//! Project version string for Violation.
FOUNDATION_EXPORT const unsigned char ViolationVersionString[];
#endif // VIOLATION_NO_FRAMEWORK

#import <Violation/ViolationDirectedPressGestureRecognizer.h>
#import <Violation/ViolationDirectionWheel.h> // imports ViolationControl.h, so no need for explicit import
#import <Violation/ViolationGearButton.h>

