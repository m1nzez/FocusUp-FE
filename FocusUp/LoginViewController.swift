//
//  LoginViewController.swift
//  FocusUp
//
//  Created by 김미주 on 17/07/2024.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var naverButton: UIButton!
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setFont()
    }
    
    // MARK: - Action
    
    // MARK: - Function
    func setAttribute() {
        kakaoButton.layer.cornerRadius = 26
        naverButton.layer.cornerRadius = 26
    }
    
    func setFont() {
        kakaoButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        kakaoButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        naverButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
    }
}
