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
 * Base class for ViolationDirectionWheel and other controls to come. A ViolationControl may be customized by specifying custom images
 * for the control in different states. If an image is available for the current control state, the control will use it and ignore the
 * fill and title colors. If the user has not specified an image, the control will use a facility like CoreGraphics or CoreAnimation to
 * render its own image. The default image may be customized using the fill and title colors in the absence of custom images. Depending
 * on the subclass and its implementation, it may be possible to customize further properties of the custom image rendered by the
 * control. Any other such customization properties for a subclass are ignored when using a custom image, just like the fill color
 * and title color in the base class.
 */
@interface ViolationControl : UIControl

#pragma mark - Public interface

/**
 * @name Public interface
 * Properties and methods inherited by subclasses.
 * @{
 */

/// Fill color for current state
@property (nonatomic, readonly) UIColor* currentFillColor;

/// Title color for current state
@property (nonatomic, readonly) UIColor* currentTitleColor;

/// Image for current state
@property (nonatomic, readonly) UIImage* currentImage;

/**
 * Sets the fill @a color to use for the specified @a state, which must be one
 * of UIControlStateNormal, UIControlStateDisabled, UIControlStateHighlighted or
 * UIControlStateSelected. Any other value of @a state is ignored.
 * @param color the fill color to use for @a state
 * @param state the state for which to use @a color
 */
- (void) setFillColor:(UIColor*)color forState:(UIControlState)state;

/**
 * Sets the title @a color to use for the specified @a state, which must be one
 * of UIControlStateNormal, UIControlStateDisabled, UIControlStateHighlighted or
 * UIControlStateSelected. Any other value of @a state is ignored.
 * @param color the title color to use for @a state
 * @param state the state for which to use @a color
 */
- (void) setTitleColor:(UIColor*)color forState:(UIControlState)state;

/**
 * Sets the @a image to use for the specified @a state, which must be one
 * of UIControlStateNormal, UIControlStateDisabled, UIControlStateHighlighted or
 * UIControlStateSelected. Any other value of @a state is ignored.
 * @param image the image to use for @a state
 * @param state the state for which to use @a image
 */
- (void) setImage:(UIImage*)image forState:(UIControlState)state;

/**
 * Fill color to use for the specified @a state. Returns the fill color for UIControlStateNormal if none (nil)
 * specified for that state. Returns nil if none specified for UIControlStateNormal.
 * @param state any valid value of a UIControlState variable, including combinations of states (UIControlStateDisabled|UIControlStateSelected, e.g.)
 * @return the fill color to use for that @a state
 */
- (UIColor*) fillColorForState:(UIControlState)state;

/**
 * Title color to use for the specified @a state. Returns the title color for UIControlStateNormal if none (nil)
 * specified for that state. Returns nil if none specified for UIControlStateNormal.
 * @param state any valid value of a UIControlState variable, including combinations of states (UIControlStateDisabled|UIControlStateSelected, e.g.)
 * @return the title color to use for that @a state
 */
- (UIColor*) titleColorForState:(UIControlState)state;

/**
 * Image to use for the specified @a state. Returns the image for UIControlStateNormal if none (nil)
 * specified for that state. Returns nil if none specified for UIControlStateNormal.
 * @param state any valid value of a UIControlState variable, including combinations of states (UIControlStateDisabled|UIControlStateSelected, e.g.)
 * @return the image to use for that @a state
 */
- (UIImage*) imageForState:(UIControlState)state;

/// @}

#pragma mark - Implementation/private

/**
 * @name Implementation/private
 * Methods used in implementation of subclasses
 * @{
 */

/**
 * To be implemented by subclasses. Called by the base class whenever
 * any of currentFillColor, currentTitleColor or currentImages changes.
 * Subclasses then redraw their images as appropriate. This could be
 * an optional method in a protocol, unimplemented by the base class,
 * which would appropriately remain abstract. But this is simpler.
 */
- (void) updateImage;

/**
 * Used in implementation to select an image or other resource based on a state.
 */
- (NSInteger)indexForState:(UIControlState)state;

/// @}

@end
