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

@implementation ViolationControl {
    UIColor* fillColor[4], *titleColor[4];
    UIImage* images[4];
}

@dynamic currentFillColor, currentTitleColor, currentImage;

- (UIImage*)currentImage
{
    return [self imageForState:self.state];
}

- (UIColor *)currentTitleColor
{
    return [self titleColorForState:self.state];
}

- (UIColor *)currentFillColor
{
    return [self fillColorForState:self.state];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self updateImage];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateImage];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateImage];
}

- (void)tintColorDidChange
{
    [self updateImage];
}

/*
 * Private method used by imageForState: and setImage:forState:.
 * For a pure state (only one bit set) other than normal, returns that bit + 1. If no
 * bits set, returns 0. If more than one bit set, returns the
 * index corresponding to the highest bit. So for state == UIControlStateNormal,
 * returns 0. For state == UIControlStateDisabled, returns 2. For
 * state == UIControlStateDisabled | UIControlStateSelected, returns 3.
 * Does not currently support UIControlStateApplication. Returns -1 if those bits are set.
 */
- (NSInteger)indexForState:(UIControlState)state
{
    if ((state & UIControlStateApplication) != 0) return -1;
    if ((state & UIControlStateSelected) != 0) return 3;
    if ((state & UIControlStateDisabled) != 0) return 2;
    if ((state & UIControlStateHighlighted) != 0) return 1;
    return 0;
}

- (UIColor *)fillColorForState:(UIControlState)state
{
    NSInteger index = [self indexForState:state];
    // NSLog(@"state index: %d", index);
    UIColor* color = index >= 0 && fillColor[index] ? fillColor[index] : fillColor[[self indexForState:UIControlStateNormal]];
    // NSLog(@"fill color is %snil", color ? "not" : "");

    if (!color) {
        CGFloat red, green, blue, alpha;
        [self.getTintColor getRed:&red green:&green blue:&blue alpha:&alpha];

        CGFloat hue, saturation, brightness;
        [self.getTintColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

        // make the interior be partly transparent by default
        alpha = 0.5;

        if ((red == green && green == blue) || brightness < 0.02) {
            /*
             * This is for any shade of gray from black to white. Unfortunately, black is not really black.
             * It comes out as a red hue. Hence the brightness test above.
             */
            CGFloat value = ((NSNumber*)@[@(0.6), @(0.8), @(0.9), @(0.8)][index]).floatValue;
            color = [UIColor colorWithRed:value green:value blue:value alpha:alpha];
        }
        else {
            saturation = ((NSNumber*)@[@(1.0), @(0.7), @(0.2), @(0.7)][index]).floatValue;
            brightness = ((NSNumber*)@[@(0.9), @(1.0), @(0.9), @(1.0)][index]).floatValue;
            color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
        }
    }

    return color;
}

- (void)setFillColor:(UIColor *)color forState:(UIControlState)state
{
    NSInteger index = [self indexForState:state];
    if (state == UIControlStateNormal || state == UIControlStateHighlighted || state == UIControlStateDisabled || state == UIControlStateSelected) {
        fillColor[index] = color;
    }

    if (index == [self indexForState:self.state]) {
        [self updateImage];
    }
}

- (UIColor *)titleColorForState:(UIControlState)state
{
    NSInteger index = [self indexForState:state];
    // NSLog(@"state index: %d", index);
    UIColor* color = index >= 0 && titleColor[index] ? titleColor[index] : titleColor[[self indexForState:UIControlStateNormal]];
    // NSLog(@"title color is %snil", color ? "not" : "");

    if (!color) {
        CGFloat red, green, blue, alpha;
        [self.getTintColor getRed:&red green:&green blue:&blue alpha:&alpha];

        CGFloat hue, saturation, brightness;
        [self.getTintColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

        if ((red == green && green == blue) || brightness < 0.02) {
            /*
             * This is for any shade of gray from black to white. Unfortunately, black is not really black.
             * It comes out as a red hue. Hence the brightness test above.
             */
            CGFloat value = ((NSNumber*)@[@(0.25), @(0.25), @(0.4), @(0.25)][index]).floatValue;
            color = [UIColor colorWithRed:value green:value blue:value alpha:alpha];
        }
        else {
            saturation = ((NSNumber*)@[@(1.0), @(1.0), @(0.2), @(1.0)][index]).floatValue;
            brightness = 0.5; // ((NSNumber*)@[@(0.5), @(0.5), @(0.5), @(0.5)][index]).floatValue;
            color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
        }
    }

    return color;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    NSInteger index = [self indexForState:state];
    if (state == UIControlStateNormal || state == UIControlStateHighlighted || state == UIControlStateDisabled || state == UIControlStateSelected) {
        titleColor[index] = color;
    }

    if (index == [self indexForState:self.state]) {
        [self updateImage];
    }
}

- (UIColor*)getTintColor
{
    /*
     * No tintColor below iOS 7. This simplifies some internal code.
     */
    if ([self respondsToSelector:@selector(tintColor)]) {
        return self.tintColor;
    }
    
    return [UIColor blueColor];
}

- (void)updateImage
{
    /*
     * For the squelching of the compiler's squealings.
     *
     * This method is to be implemented by subclasses. This class really just doesn't have this method. Could do this
     * using a protocol with an @optional method and then perhaps check respondsToSelector: before calling it. I think
     * this is hella simpler.
     */
}

- (UIImage *)imageForState:(UIControlState)state
{
    NSInteger index = [self indexForState:state];
    /*
     * Like UIButton, use the image for UIControlStateNormal if none present.
     */
    // Mmmm. Double square brackets in the last expression of the ternary conditional: outer for the array subscript, inner for a method call.
    return index >= 0 && images[index] ? images[index] : images[[self indexForState:UIControlStateNormal]];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    NSInteger index = [self indexForState:state];
    /*
     * Don't accept mixed states here. Cannot pass, e.g., UIControlStateHighlighted & UIControlStateDisabled.
     * Those values are ignored here.
     */
    if (state == UIControlStateNormal || state == UIControlStateHighlighted || state == UIControlStateDisabled || state == UIControlStateSelected) {
        images[index] = image;
    }

    /*
     * The method parameter state must be one of the four enumerated values listed above.
     * But self.state could be a mixed state. Conceivably, the control could be
     * both disabled and highlighted. In that case, since disabled is numerically
     * greater than highlighted, we return the index/image for UIControlStateDisabled.
     * (See indexForState: below.) That is to say, the following expression is always true:
     * [self indexForState:UIControlStateDisabled] == [self indexForState:UIControlStateHighlighted|UIControlStateDisabled]
     * If we just now changed the image currently in use (the image for the current state), update it now.
     */
    if (index == [self indexForState:self.state]) {
        [self updateImage];
    }
}

@end
