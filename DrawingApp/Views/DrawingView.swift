import UIKit

class DrawingView: UIView {
    
    private var lines = [Line]()
    private var strokeColor: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    private var strokeWidth: CGFloat = 1
    @IBOutlet weak var strokeWidthSlider: UISlider!
    @IBOutlet weak var pickColorButton: UIButton! {
        didSet {
            pickColorButton.layer.borderWidth = 1
            pickColorButton.layer.borderColor = UIColor.black.cgColor
            pickColorButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        transformSlider()
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                }else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor, strokeWidth: strokeWidth, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setStrokeColor(_ color: UIColor, alpha: CGFloat) {
        pickColorButton.backgroundColor = color
        pickColorButton.alpha = alpha
        strokeColor = color.withAlphaComponent(alpha)
        setNeedsDisplay()
    }
    
    func setStrokeWidth(width: Float) {
        strokeWidth = CGFloat(width)
    }
    
    func transformSlider() {
        strokeWidthSlider.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi/2)
    }
    func drawButtonBorder() {
        let path = UIBezierPath()
        UIColor.black.setStroke()
        let radius = pickColorButton.frame.width/2 + 2
        let offset = pickColorButton.center
        let numberOfPoints = 360
        
        let pointX = 0
        let pointY = 0
        for gap in 0...numberOfPoints {
            
            let point = calculatePoint(x: CGFloat(pointX+gap), y: CGFloat(pointY+gap), radius: radius, offset: offset)
            if gap == 0 {
                path.move(to: point)
            }
            path.addLine(to: point)
            
        }
        
        path.stroke()
        
        
    }
    
    func calculatePoint(x: CGFloat, y:CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint{
        let x = cos(x)*radius+offset.x
        let y = sin(y)*radius+offset.y
        
        return CGPoint(x: x, y: y)
        
    }
}

