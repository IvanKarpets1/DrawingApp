import UIKit

protocol TransferColorProtocol: class {
    func setPickedColor(color: UIColor, alpha: CGFloat)
}

class ColorPickerVC: UIViewController {

    @IBOutlet var colorPickerView: ColorPickerView!
    
    @IBOutlet weak var colorCircle: UIView!
    
    var delegate: TransferColorProtocol!
    
    var alpha: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleChangeCircleColor(_ sender: UISlider) {
        colorPickerView.changeCircleColor(hue: CGFloat(sender.value))
       
    }
    
    @IBAction func handleChangeCircleAlpha(_ sender: UISlider) {
        alpha = CGFloat(sender.value)
        colorPickerView.changeCircleAlpha(alpha: CGFloat(sender.value))
    }
    @IBAction func handleChangeCircleBrightness(_ sender: UISlider) {
        colorPickerView.changeCircleBrightness(brightness: CGFloat(sender.value))
        
    }
    @IBAction func handleChangeStrokeColor(_ sender: UIButton) {
        guard let color = colorCircle.backgroundColor else {
            return
        }
        delegate?.setPickedColor(color: color, alpha: alpha)
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
