//
//  CustomAlertViewController.swift
//  FocusUp
//
//  Created by 김미주 on 01/08/2024.
//

import UIKit

protocol CustomAlertCancelDelegate {
    func action()
    func exit()
}

class CustomAlertCancelViewController: UIViewController {
    // MARK: - Property
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    var delegate: CustomAlertCancelDelegate?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setFont()
    }
    
    // MARK: - Action
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.exit()
        }
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.action()
        }
    }
    
    // MARK: - Function
    func setAttribute() {
        background.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        alertView.layer.cornerRadius = 14
        alertView.clipsToBounds = true
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.blueGray4.cgColor
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor.blueGray4.cgColor
    }
    
    func setFont() {
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        subTitleLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        cancelButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 17)
        confirmButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
    }
    
}
