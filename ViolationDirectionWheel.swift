/*
Copyright (c) 2014, Jimmy Dee
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit

class ViolationDirectionWheel: UIControl {
    var isPressed : Bool = false
    var direction : Double = 0.0 // radians ccw from east

    override var hidden : Bool {
    didSet {
        isPressed = false
    }
    }

    init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(ViolationDirectedPressGestureRecognizer(target: self, action: "handleDirectedPress:"))
    }

    func handleDirectedPress(sender: ViolationDirectedPressGestureRecognizer) {
        /*
         * Here's hoping all the toRaw() and back stuff below is right.
         * We generate a .ValueChanged event whenever anything happens.
         * We also generate .TouchDown, .TouchDragInside, .TouchUpInside and .TouchCancel events
         * as appropriate.
         */
        let valueChanged = UIControlEvents.ValueChanged.toRaw() // UInt

        switch (sender.state) {
        case .Ended:
            isPressed = false
            sendActionsForControlEvents(UIControlEvents(valueChanged | UIControlEvents.TouchDown.toRaw()))
        case .Cancelled:
            isPressed = false
            sendActionsForControlEvents(UIControlEvents(valueChanged | UIControlEvents.TouchCancel.toRaw()))
        case .Began:
            updateDirection(sender)
            isPressed = true
            sendActionsForControlEvents(UIControlEvents(valueChanged | UIControlEvents.TouchDown.toRaw()))
        case .Changed:
            updateDirection(sender)
            sendActionsForControlEvents(UIControlEvents(valueChanged | UIControlEvents.TouchDragInside.toRaw()))
        default:
            break
        }
    }

    func updateDirection(sender: ViolationDirectedPressGestureRecognizer) {
        let location = sender.locationInView(self)
        let width = Double(frame.size.width)
        let height = Double(frame.size.height)

        let y = 0.5 * height - Double(location.y)
        let x = Double(location.x) - 0.5 * width

        direction = atan2(y, x)
    }
}
