// InformationModalViewController.swift

import UIKit

class InformationViewController: UIViewController {
    // MARK: - Property
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
    }
    
    // MARK: - Function
    func setFont() {
        infoLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        subLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
}
