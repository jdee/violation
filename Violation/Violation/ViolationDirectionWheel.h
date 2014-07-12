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

#import "ViolationControl.h"

/**
 * @headerfile Violation.h <Violation/Violation.h>
 *
 * The ViolationDirectionWheel uses the ViolationDirectedPressGestureRecognizer to generate a UIControlEventValueChanged
 * any time a touch goes down, comes up or moves in the control's view. Whenever that event is generated, the isPressed
 * property should first be consulted to determine if the control is pressed. If it is, the direction property may also
 * be consulted to determine the direction of the press relative to the center of the view. Moving a touch radially away
 * from or toward the center of the view will not change the value of direction, which is an angle measured in radians
 * counterclockwise from east.
 *
 * The control uses CoreGraphics to draw a default image that may be customized using the fill and title colors of the
 * base ViolationControl class and the innerRadius and lineWidth properties of this class, as well as an optional title or
 * title image per state. When drawing its default image, the control can include at its center an optional title per
 * state. Alternately, a title image per state may be rendered at the center of the control. If both a title image and
 * a title (string) are specified for a given control state, the image will be rendered. Both the title and title image
 * for a control state are ignored if a custom image for the control is specified via [ViolationControl setImage:forState:].
 */
@interface ViolationDirectionWheel : ViolationControl

#pragma mark - Control output

/**
 * @name Control output
 * Read-only properties specifying the state of the control's gesture handling.
 * @{
 */

/**
 * Specifies whether the control is currently pressed. If NO, the direction property is not valid.
 */
@property (nonatomic, readonly) BOOL isPressed;

/**
 * Specifies the direction of the last touch relative to the center of the control, as an angle in radians measured
 * counterclockwise from east (the positive x axis if the center of the control is at the origin). The output lies
 * in (-M_PI,M_PI]. East is 0 radians; north is M_PI/2; west is M_PI; south is -M_PI/2. This property should be
 * ignored if the isPressed property is NO.
 */
@property (nonatomic, readonly) double direction;

/// @}

#pragma mark - Default image customization

/**
 * @name Default image customization
 * Methods and properties used to customize the default image generated by the control whenever a custom image
 * is not available for the current control state.
 * @{
 */

/** 
 * @brief The radius of the inner ring in the default view.
 * This is an absolute value, in points. If you change the frame size,
 * you should probably also change this. It may change to be a proportion in the future so that a change to the frame
 * size will retain the same relative dimensions. Defaults to 0.3 * MIN(frame.size.width, frame.size.height).
 */
@property (nonatomic) double innerRadius;

/// The line width to use when drawing the inner and outer rings in the default image. Default is 8.0.
@property (nonatomic) double lineWidth;

/// The title string to render for the current state
@property (nonatomic, readonly) NSString* currentTitle;

/// The title image to render for the current state
@property (nonatomic, readonly) UIImage* currentTitleImage;

/**
 * Title image to use for the specified @a state. Returns the title image for UIControlStateNormal if none (nil)
 * specified for that state. Returns nil if none specified for UIControlStateNormal.
 * @param state any valid value of a UIControlState variable, including combinations of states (UIControlStateDisabled|UIControlStateSelected, e.g.)
 * @return the title image to use for that @a state
 */
- (NSString*) titleForState:(UIControlState)state;

/**
 * Title image to use for the specified @a state. Returns the title image for UIControlStateNormal if none (nil)
 * specified for that state. Returns nil if none specified for UIControlStateNormal.
 * @param state any valid value of a UIControlState variable, including combinations of states (UIControlStateDisabled|UIControlStateSelected, e.g.)
 * @return the title image to use for that @a state
 */
- (UIImage*) titleImageForState:(UIControlState)state;

/**
 * Sets the @a title to use for the specified @a state, which must be one
 * of UIControlStateNormal, UIControlStateDisabled, UIControlStateHighlighted or
 * UIControlStateSelected. Any other value of @a state is ignored.
 * @param title the title to use for @a state
 * @param state the state for which to use @a title
 */
- (void) setTitle:(NSString*)title forState:(UIControlState)state;

/**
 * Sets the title @a image to use for the specified @a state, which must be one
 * of UIControlStateNormal, UIControlStateDisabled, UIControlStateHighlighted or
 * UIControlStateSelected. Any other value of @a state is ignored.
 * @param image the title image to use for @a state
 * @param state the state for which to use @a image
 */
- (void) setTitleImage:(UIImage*)image forState:(UIControlState)state;

/// @}

@end
