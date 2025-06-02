import UIKit

class FSPressableButton: UIButton {
    enum Style {
        case grapefruit
        case aqua
    }
    
    private let style: Style
    private var originalBackgroundColor: UIColor?
    private var shadowLayer: CALayer?
    
    init(frame: CGRect, style: Style) {
        self.style = style
        super.init(frame: frame)
        setupStyle()
        setupShadow()
        addTarget(self, action: #selector(pressDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(pressUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        layer.cornerRadius = 12
        layer.masksToBounds = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        switch style {
        case .grapefruit:
            backgroundColor = UIColor(red: 1.0, green: 0.36, blue: 0.36, alpha: 1.0)
            setTitleColor(.white, for: .normal)
        case .aqua:
            backgroundColor = UIColor(red: 0.0, green: 0.78, blue: 0.98, alpha: 1.0)
            setTitleColor(.white, for: .normal)
        }
        originalBackgroundColor = backgroundColor
    }
    
    private func setupShadow() {
        shadowLayer = CALayer()
        shadowLayer?.shadowColor = UIColor.black.cgColor
        shadowLayer?.shadowOffset = CGSize(width: 0, height: 4)
        shadowLayer?.shadowRadius = 6
        shadowLayer?.shadowOpacity = 0.3
        shadowLayer?.frame = bounds
        shadowLayer?.cornerRadius = layer.cornerRadius
        if let shadowLayer = shadowLayer {
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer?.frame = bounds
    }
    
    @objc private func pressDown() {
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = self.originalBackgroundColor?.withAlphaComponent(0.7)
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }
    }
    
    @objc private func pressUp() {
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = self.originalBackgroundColor
            self.transform = .identity
        }
    }
} 