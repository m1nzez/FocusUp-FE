//
//  LoginViewController.swift
//  FocusUp
//
//  Created by 김미주 on 17/07/2024.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    @IBOutlet weak var snsLabel: UILabel!
    @IBOutlet weak var emailErrorImage: UIImageView!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorImage: UIImageView!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setFont()
        setHideError()
    
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .editingChanged)
    }

    // MARK: - Action
    
    // MARK: - Function
    func setAttribute() {
        emailTextField.layer.borderColor = UIColor.blueGray2.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 8
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        emailTextField.leftViewMode = .always
        
        passwordTextField.layer.borderColor = UIColor.blueGray2.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        passwordTextField.leftViewMode = .always
        
        loginButton.layer.borderColor = UIColor.primary4.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 28
    }
    
    func setFont() {
        emailLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        emailTextField.font = UIFont(name: "Pretendard-Regular", size: 16)
        passwordLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        passwordTextField.font = UIFont(name: "Pretendard-Regular", size: 16)
        loginButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        signupButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
        findPasswordButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
        snsLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    func setHideError() {
        emailErrorImage.isHidden = true
        emailErrorLabel.isHidden = true
        passwordErrorImage.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    // MARK: - ValidFunction
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == emailTextField {
            if isValidEmail(emailTextField.text) {
                emailTextField.layer.borderColor = UIColor.primary4.cgColor
                emailTextField.textColor = UIColor.primary4
                emailErrorImage.isHidden = true
                emailErrorLabel.isHidden = true
            } else {
                emailTextField.layer.borderColor = UIColor.emphasizeError.cgColor
                emailTextField.textColor = UIColor.emphasizeError
                emailErrorImage.isHidden = false
                emailErrorLabel.isHidden = false
            }
        }
        
        else if textField == passwordTextField {
            if isValidPassword(passwordTextField.text) {
                passwordTextField.layer.borderColor = UIColor.primary4.cgColor
                passwordTextField.textColor = UIColor.primary4
                passwordErrorImage.isHidden = true
                passwordErrorLabel.isHidden = true
            } else {
                passwordTextField.layer.borderColor = UIColor.emphasizeError.cgColor
                passwordTextField.textColor = UIColor.emphasizeError
                passwordErrorImage.isHidden = false
                passwordErrorLabel.isHidden = false
            }
        }
        setLoginButton()
    }
    
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        return password.count >= 8
    }
    
    func setLoginButton() {
        if isValidEmail(emailTextField.text) && isValidPassword(passwordTextField.text) {
            loginButton.backgroundColor = UIColor.primary4
            loginButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            loginButton.backgroundColor = UIColor.white
            loginButton.setTitleColor(UIColor.black, for: .normal)
        }
    }

}
