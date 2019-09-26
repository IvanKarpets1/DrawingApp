import UIKit

class ColorPickerView: UIView {
    @IBOutlet weak var colorCircle: UIView!

    @IBOutlet weak var changeBrightnessSlider: UISlider!
    
    @IBOutlet weak var changeColorSlider: UISlider!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var changeAlphaSlider: UISlider!
    
    private var hueValue: CGFloat = 1.0
    
    var alphaGradientLayer: CAGradientLayer = CAGradientLayer()
    var brightnessGradientLayer: CAGradientLayer = CAGradientLayer()
    var colorGradientLayer: CAGradientLayer = CAGradientLayer()

    override func draw(_ rect: CGRect) {
        
        setupGradients()
    }
    
    func setupGradients() {
        
        changeColorSlider.layer.addColorsGradient(colors: [UIColor.red, UIColor.yellow, UIColor.green, UIColor.cyan, UIColor.blue, UIColor.purple, UIColor.magenta, UIColor.red])
        colorCircle.backgroundColor = UIColor(hue: 1.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        changeAlphaSlider.layer.addTwoColorsGradient(colors: [UIColor.white, colorCircle.backgroundColor!])
        changeBrightnessSlider.layer.addTwoColorsGradient(colors: [UIColor.black, colorCircle.backgroundColor!])
    }
    
    func changeCircleColor(hue: CGFloat) {
        let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        colorCircle.backgroundColor = color
        hueValue = hue
        doneButton.setTitleColor(color, for: .normal)
        changeAlphaSliderBackground(color: color)
        changeBrightnessSliderBackground(color: color)
        
    }
    
    func changeCircleAlpha(alpha: CGFloat) {
        colorCircle.alpha = alpha
    }
    
    func changeCircleBrightness(brightness: CGFloat) {
        let color = UIColor(hue: hueValue, saturation: 1.0, brightness: brightness, alpha: 1.0)
        colorCircle.backgroundColor = color
        doneButton.setTitleColor(colorCircle.backgroundColor, for: .normal)
        
        
    }
    
    func changeBrightnessSliderBackground(color: UIColor) {
        changeBrightnessSlider.layer.addTwoColorsGradient(colors: [UIColor.black, color])
    }
    
    func changeAlphaSliderBackground(color: UIColor) {
        alphaGradientLayer.removeFromSuperlayer()
        changeAlphaSlider.layer.addTwoColorsGradient(colors: [UIColor.white, color])
        
    }
}


extension CALayer {
    func addColorsGradient(colors: [UIColor]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0, 0.2, 0.4, 0.5, 0.7, 0.8, 0.85, 1.0] as [NSNumber]
        gradientLayer.frame = bounds
        
        insertSublayer(gradientLayer, at: UInt32(sublayers?.count ?? 0))
        
    }
    
    func addTwoColorsGradient(colors: [UIColor]) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors.map { $0.cgColor }
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.locations = [0.0, 0.7] as [NSNumber]
            gradientLayer.frame = bounds
        
            insertSublayer(gradientLayer, at: UInt32(sublayers?.count ?? 0))
    }
}


