//
//  JoinViewController.swift
//  FocusUp
//
//  Created by 김미주 on 19/07/2024.
//

import UIKit

class JoinViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var joinLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmLabel: UILabel!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var snsLoginLabel: UILabel!
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setFont()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
    }
    
    // MARK: - Action
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    // MARK: - Function
    func setAttribute() {
        setTextFieldAttribute(for: emailTextField)
        setTextFieldAttribute(for: passwordTextField)
        setTextFieldAttribute(for: passwordConfirmTextField)
        
        joinButton.layer.borderColor = UIColor.primary4.cgColor
        joinButton.layer.borderWidth = 1
        joinButton.layer.cornerRadius = 28
    }
    
    func setTextFieldAttribute(for textField: UITextField) {
        textField.layer.borderColor = UIColor.blueGray2.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        textField.leftViewMode = .always
    }
    
    func setFont() {
        joinLabel.font = UIFont(name: "Pretendard-Regular", size: 18)
        emailLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        emailTextField.font = UIFont(name: "Pretendard-Regular", size: 16)
        passwordLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        passwordTextField.font = UIFont(name: "Pretendard-Regular", size: 16)
        passwordConfirmLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        passwordConfirmTextField.font = UIFont(name: "Pretendard-Regular", size: 16)
        joinButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        snsLoginLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
    }

}

// MARK: - UITextFieldDelegate
extension JoinViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            textField.layer.borderColor = UIColor.primary4.cgColor
            textField.textColor = UIColor.primary4
        } else if textField == passwordTextField {
            textField.layer.borderColor = UIColor.primary4.cgColor
            textField.textColor = UIColor.primary4
        } else if textField == passwordConfirmTextField {
            textField.layer.borderColor = UIColor.primary4.cgColor
            textField.textColor = UIColor.primary4
        }
        textField.tintColor = UIColor.primary4
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            textField.layer.borderColor = UIColor.primary2.cgColor
            textField.textColor = UIColor.primary4
        } else if textField == passwordTextField {
            textField.layer.borderColor = UIColor.primary2.cgColor
            textField.textColor = UIColor.primary4
        } else if textField == passwordConfirmTextField {
            textField.layer.borderColor = UIColor.primary2.cgColor
            textField.textColor = UIColor.primary4
        }
    }
}
