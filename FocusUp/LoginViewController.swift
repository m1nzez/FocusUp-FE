//
//  LoginViewController.swift
//  FocusUp
//
//  Created by 김미주 on 17/07/2024.
//

import UIKit
import KakaoSDKUser

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
    @IBAction func kakaoButtonTapped(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    guard let mainVC = self.storyboard?.instantiateViewController(identifier: "CustomTabBarController") as? CustomTabBarController else { return }
                    mainVC.modalTransitionStyle = .coverVertical
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC, animated: true, completion: nil)
                    
                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoAccount() success.")
                    
                    _ = oauthToken
                }
            }
        }
    }
    
    
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
