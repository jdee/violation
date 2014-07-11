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

import UIKit
import Violation

class GestureViewController: UIViewController {

    @IBOutlet var input : UIView
    @IBOutlet var output : UIView

    var star : UIImageView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        input.addGestureRecognizer(ViolationDirectedPressGestureRecognizer(target:self, action: "handleDirectedPress:"))

        star = UIImageView(image: UIImage(named: "hammer_sickle_in_star"))
        star.hidden = true
        output.addSubview(star)
    }

    func handleDirectedPress(sender: ViolationDirectedPressGestureRecognizer) {
        switch (sender.state) {
        case .Cancelled, .Ended:
            star.hidden = true
            // NSLog("gesture cancelled or ended")
        case .Began:
            setStarFrame(sender)
            star.hidden = false
            // NSLog("gesture began")
        case .Changed:
            setStarFrame(sender)
            // NSLog("gesture changed")
        default:
            break
        }
    }

    func setStarFrame(sender: ViolationDirectedPressGestureRecognizer) {
        let location = sender.locationInView(input)
        star.frame.origin.x = location.x - star.frame.size.width * 0.5
        star.frame.origin.y = location.y - star.frame.size.height * 0.5
    }
}

