import UIKit

class ViewController: UIViewController, TransferColorProtocol {
    
    @IBOutlet var drawingView: DrawingView!
    
    weak var colorPickerVC: ColorPickerVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addGradient(color1: UIColor.red ,color2: UIColor.blue)
    }
    
    @IBAction func handleUndo(_ sender: Any) {
        drawingView.undo()
    }
    
    @IBAction func handleClear(_ sender: Any) {
        drawingView.clear()
    }
    
    @IBAction func handleChangeStrokeWidth(_ sender: UISlider) {
        drawingView.setStrokeWidth(width: sender.value)
    }
    
    @IBAction func presentColorPickerView(_ sender: UIButton) {
        let alertVC = AlertService().getAlertVC(viewController: self)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func setPickedColor(color: UIColor, alpha: CGFloat) {
        drawingView.setStrokeColor(color, alpha: alpha)
    }
}

