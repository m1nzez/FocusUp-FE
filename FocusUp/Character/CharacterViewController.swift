import UIKit

class CharacterViewController: UIViewController {
    
    @IBOutlet var shellfishView: UIView!
    @IBOutlet var bottomButton: UIButton!
    @IBOutlet var shopButton: UIButton!
    @IBOutlet var bgView: UIImageView!
    
    @IBOutlet var shellNum: UILabel!
    @IBOutlet var fishNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShellfishViewBorder()
        setupBottomButtonBorder()
        setupShopButtonAppearance()
//        setupVerticalTextForButton()
    }
    
    private func setupBottomButtonBorder() {
        let borderLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bottomButton.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 26.0, height: 26.0))
        
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor(red: 234/255.0, green: 236/255.0, blue: 240/255.0, alpha: 1.0).cgColor
        borderLayer.lineWidth = 1.0
        
        bottomButton.layer.sublayers?.removeAll { $0 is CAShapeLayer }
        
        bottomButton.layer.addSublayer(borderLayer)
    }
    
    private func setupShellfishViewBorder() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: shellfishView.frame.height - 1, width: shellfishView.frame.width, height: 1)
        bottomBorder.backgroundColor = UIColor(red: 229/255.0, green: 231/255.0, blue: 235/255.0, alpha: 1.0).cgColor
        
        shellfishView.layer.sublayers?.removeAll { $0.backgroundColor == bottomBorder.backgroundColor }
        
        shellfishView.layer.addSublayer(bottomBorder)
    }
    
    private func setupShopButtonAppearance() {
        shopButton.layer.shadowColor = UIColor(red: 34/255.0, green: 88/255.0, blue: 113/255.0, alpha: 0.3).cgColor
        shopButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 0px 2px
        shopButton.layer.shadowRadius = 2 // 2px
        shopButton.layer.shadowOpacity = 1
        shopButton.layer.masksToBounds = false
        
        shopButton.layer.cornerRadius = 12
        shopButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    private func setupVerticalTextForButton() {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.titleAlignment = .center
            configuration.titlePadding = 10
            shopButton.configuration = configuration
            
            shopButton.setTitle("Vertical Text", for: .normal)
            shopButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            
            shopButton.frame.size = CGSize(width: 44, height: 200)
        } else {
            shopButton.titleLabel?.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            shopButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBottomButtonBorder()
        setupShellfishViewBorder()
        setupShopButtonAppearance()
//        setupVerticalTextForButton()
    }
}
