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
import Violation

class ControlViewController: UIViewController {

    @IBOutlet var controlHolder : UIView
    @IBOutlet var dialHolder : UIView

    var directionWheel : ViolationDirectionWheel!
    var dialView : IOSKnobControl!
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        directionWheel = ViolationDirectionWheel(frame: controlHolder.bounds)
        directionWheel.addTarget(self, action: "somethingChanged:", forControlEvents: .ValueChanged)

        directionWheel.setTitle("press", forState: .Normal)
        directionWheel.setTitle("", forState: .Highlighted)
        directionWheel.setFillColor(UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.5), forState: .Normal)
        directionWheel.setTitleColor(UIColor.blackColor(), forState: .Normal)
        directionWheel.setTitleColor(UIColor(red:0.5, green:0.5, blue:0.0, alpha:1.0), forState: .Highlighted)

        controlHolder.addSubview(directionWheel)

        dialView = IOSKnobControl(frame: dialHolder.bounds, imageNamed: "needle")
        dialView.enabled = false
        dialView.hidden = true
        dialHolder.addSubview(dialView)
    }

    func somethingChanged(sender: ViolationDirectionWheel) {
        // NSLog("something changed: isPressed: %@, direction: %f", sender.isPressed ? "true" : "false", sender.direction)
        dialView.hidden = !sender.isPressed
        dialView.position = Float(sender.direction - M_PI*0.5)
    }
}

