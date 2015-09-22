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

class ButtonViewController: UIViewController {

    @IBOutlet var buttonHolder: UIView!
    @IBOutlet var teethKnobHolder: UIView!
    @IBOutlet var rotationKnobHolder: UIView!
    @IBOutlet var innerRingSlider: UISlider!
    @IBOutlet var innerToothSlider: UISlider!
    @IBOutlet var toolbar: UIToolbar!
    var button: ViolationGearButton!
    var teethKnob: IOSKnobControl!
    var rotationKnob: IOSKnobControl!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTabBarItem()
    }

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBarItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController!.tabBar.translucent = false

        assert(tabBarItem.tag == 2)
        assert(tabBarController!.viewControllers!.count == 3)
        assert(tabBarController!.viewControllers![2] === self)

        button = ViolationGearButton(frame: buttonHolder.bounds)
        buttonHolder.addSubview(button)

        button.numTeeth = 10
        button.lineWidth = 2
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Highlighted)

        teethKnob = IOSKnobControl(frame: teethKnobHolder.bounds)
        teethKnob.mode = .LinearReturn
        teethKnob.positions = 7
        teethKnob.titles = [ "6", "7", "8", "9", "10", "11", "12" ]
        teethKnob.positionIndex = 4 // 10 teeth to start
        teethKnob.addTarget(self, action: "numTeethChanged:", forControlEvents: .ValueChanged)
        teethKnob.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        teethKnobHolder.addSubview(teethKnob)

        rotationKnob = IOSKnobControl(frame: rotationKnobHolder.bounds)
        rotationKnob.mode = .Continuous
        rotationKnob.circular = true
        rotationKnob.normalized = true
        rotationKnob.clockwise = false
        rotationKnob.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rotationKnob.addTarget(self, action: "rotationChanged:", forControlEvents: .ValueChanged)
        rotationKnobHolder.addSubview(rotationKnob)

        let barButtonItem = ViolationGearBarButtonItem(target:self, action:"toolbarButtonPressed:")
        barButtonItem.button.numTeeth = 8
        barButtonItem.button.lineWidth = 1
        barButtonItem.button.rotation = CGFloat(M_PI/8)
        barButtonItem.button.setTitleColor(UIColor.brownColor(), forState: .Normal)
        barButtonItem.button.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        toolbar.items = [ barButtonItem ]
    }

    func numTeethChanged(sender: IOSKnobControl!) {
        let numTeeth = UInt(sender.positionIndex) + 6
        button.numTeeth = numTeeth
    }

    func rotationChanged(sender: IOSKnobControl!) {
        button.rotation = CGFloat(sender.position)
    }

    @IBAction
    func innerRingRatioChanged(sender: UISlider!) {
        button.innerRingRatio = CGFloat(sender.value)
    }

    @IBAction
    func innerToothRatioChanged(sender: UISlider!) {
        button.innerToothRatio = CGFloat(sender.value)
    }

    func toolbarButtonPressed(sender: ViolationGearBarButtonItem!) {
    }

    private func setupTabBarItem() {
        let dummy = ViolationGearButton(frame: CGRectMake(0, 0, 44, 44))
        dummy.numTeeth = 10
        dummy.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dummy.innerRingRatio = 0

        tabBarItem = UITabBarItem(title: "Button", image: dummy.image, tag: 2)
    }

}
