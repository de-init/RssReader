import UIKit

class CustomNavigationBar: UIView {
    let animatingView: UIView
    let animationStyle: AnimationStyle
    
    init(animatingView: UIView, animationStyle: AnimationStyle = .leftToCenter) {
        self.animatingView = animatingView
        self.animationStyle = animationStyle
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomNavigationBar {
    private func setupUI() {
        animatingView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animatingView)
        adjustTitleView()
    }
    
    private func adjustTitleView() {
        switch animationStyle {
        case .leftToCenter:
            animatingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
            animatingView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
            animatingView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        }
    }
}

extension CustomNavigationBar {
    public func animateInRelationTo(_ value: CGFloat) {
         switch animationStyle {
         case .leftToCenter:
             let maxOffsetValue = max(value, 16)
             let translationX = min(maxOffsetValue, (UIScreen.main.bounds.width/2 - self.animatingView.frame.width/2))
             self.animatingView.transform = CGAffineTransform(translationX: translationX, y: 0)
         }
     }
}
