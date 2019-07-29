import UIKit

public struct TDSwiftRoundedIconGradientButtonConfig {
    let iconImage: UIImage
    let gradientColorA: UIColor
    let gradientColorB: UIColor
    let gradientAX: Double
    let gradientAY: Double
    let gradientBX: Double
    let gradientBY: Double
}

public class TDSwiftRoundedIconGradientButton: UIButton {
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    public var iconImage: UIImage = UIImage()
    
    @IBInspectable
    public var gradientColorA: UIColor = UIColor(red:0.28, green:0.46, blue:0.90, alpha:1.0)
    
    @IBInspectable
    public var gradientColorB: UIColor = UIColor(red:0.56, green:0.33, blue:0.91, alpha:1.0)
    
    @IBInspectable
    public var gradientAX: Double = 0.0
    
    @IBInspectable
    public var gradientAY: Double = 0.5
    
    @IBInspectable
    public var gradientBX: Double = 1.0
    
    @IBInspectable
    public var gradientBY: Double = 0.5
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        updateButtonAppearance()
    }
    
    public init(frame: CGRect, config: TDSwiftRoundedIconGradientButtonConfig) {
        super.init(frame: frame)
        updateButtonAppearance()
        
        // Init property
        self.iconImage = config.iconImage
        self.gradientColorA = config.gradientColorA
        self.gradientColorB = config.gradientColorB
        self.gradientAX = config.gradientAX
        self.gradientAY = config.gradientAY
        self.gradientBX = config.gradientBX
        self.gradientBY = config.gradientBY
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateButtonAppearance()
    }
    
    public func updateButtonAppearance() {
        // Remove old sublayers
        self.layer.sublayers?.removeAll()
        
        // Gradient background
        gradientLayer.frame = bounds
        gradientLayer.colors = [gradientColorA, gradientColorB].map {$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: gradientAX, y: gradientAY)
        gradientLayer.endPoint = CGPoint (x: gradientBX, y: gradientBY)
        self.layer.addSublayer(gradientLayer)
        
        // Shadow
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        
        // Shape layer
        let roundedCornerMaskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: self.frame.height / 2, height: self.frame.height / 2))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = roundedCornerMaskPath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.frame = layer.bounds
        layer.backgroundColor = UIColor.clear.cgColor
        gradientLayer.mask = shapeLayer
    }
}
