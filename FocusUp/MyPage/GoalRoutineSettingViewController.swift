//
//  GoalRoutineSettingViewController.swift
//  FocusUp
//
//  Created by 성호은 on 7/24/24.
//

import UIKit

class GoalRoutineSettingViewController: UIViewController {
    // MARK: - property
    @IBOutlet weak var goalRoutineLabel3: UILabel!
    @IBOutlet weak var goalRoutineInput: UITextField!
    @IBOutlet weak var repeatPeriodLabel: UILabel!
    @IBOutlet weak var weekStackButton: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "목표 루틴 설정"
        
        self.goalRoutineLabel3.font = UIFont(name: "Pretendard-Medium.otf", size: 15)
        self.repeatPeriodLabel.font = UIFont(name: "Pretendard-Medium.otf", size: 15)
        
        self.goalRoutineInput.attributedPlaceholder = NSAttributedString(string: "목표 루틴 입력", 
             attributes: [NSAttributedString.Key.foregroundColor: UIColor.primary4,
                          NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium.otf", size: 16) ?? .boldSystemFont(ofSize: 16)])
        self.goalRoutineInput.layer.cornerRadius = 8
        self.goalRoutineInput.layer.borderWidth = 1
        self.goalRoutineInput.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        
        self.goalRoutineInput.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        self.goalRoutineInput.leftViewMode = .always
        
        self.setWeekStackViewButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let customFont = UIFont(name: "Pretendard-Regular", size: 18) {
            let textAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: customFont
            ]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            print("커스텀 폰트를 로드할 수 없습니다.")
        }
        
        let backButton = UIImage(named: "arrow_left.svg")
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: backButton, style: .plain, target: self, action: #selector(completeButtonDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonDidTap))
        
        if let buttonFont = UIFont(name: "Pretendard-Medium", size: 16) {
            rightBarButton.setTitleTextAttributes([.font: buttonFont], for: .normal)
            rightBarButton.setTitleTextAttributes([.font: buttonFont], for: .highlighted)
        }
        
        rightBarButton.tintColor = UIColor(named: "Primary4")
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let spacer = UIView()
        spacer.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        let rightBarButtonWithSpacer = UIBarButtonItem(customView: spacer)
        self.navigationItem.rightBarButtonItems = [rightBarButtonWithSpacer, rightBarButton]
        
    }
    
    // MARK: - action
    private func setWeekStackViewButton() {
        for case let button as UIButton in weekStackButton.arrangedSubviews {
            setButton(button)
        }
    }
    
    private func setButton(_ button: UIButton) {
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func completeButtonDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        UIView.performWithoutAnimation {
            if sender.isSelected {
                sender.isSelected = false
                sender.backgroundColor = UIColor.white
                sender.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
                sender.setTitleColor(UIColor.black, for: .normal)
            } else {
                sender.isSelected = true
                sender.backgroundColor = UIColor.primary4
                sender.layer.borderColor = UIColor.clear.cgColor
                sender.setTitleColor(UIColor.white, for: .normal)
            }
            sender.layoutIfNeeded()
        }
    }

}
