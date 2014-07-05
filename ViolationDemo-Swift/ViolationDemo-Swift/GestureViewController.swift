import UIKit

class GestureViewController: UIViewController {

    @IBOutlet var input : UIView
    @IBOutlet var output : UIView

    var star : UIImageView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        let directedPressGestureRecognizer = ViolationDirectedPressGestureRecognizer(target:self, action: "handleDirectedPress:")
        input.addGestureRecognizer(directedPressGestureRecognizer)

        star = UIImageView(image: UIImage(named: "hammer_sickle_in_star"))
    }

    func handleDirectedPress(sender: ViolationDirectedPressGestureRecognizer) {
        switch (sender.state) {
        case .Cancelled, .Ended:
            star.removeFromSuperview()
        case .Began:
            setStarFrame(sender)
            output.addSubview(star)
        case .Changed:
            setStarFrame(sender)
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

