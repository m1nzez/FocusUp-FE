//
//  GoalRoutineSettingViewController.swift
//  FocusUp
//
//  Created by 성호은 on 7/24/24.
//

import UIKit

class GoalRoutineSettingViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var goalRoutineLabel: UILabel!
    @IBOutlet weak var goalRoutineTextField: UITextField!
    @IBOutlet weak var repeatPeriodLabel: UILabel!
    @IBOutlet weak var weekStackButton: UIStackView!
    @IBOutlet weak var startTimeTitleLabel: UILabel!
    @IBOutlet weak var startTimeView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var goalTimeTitleLabel: UILabel!
    @IBOutlet weak var goalTimeView: UIView!
    @IBOutlet weak var goalTimeLabel: UILabel!
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setFont()
        setWeekStackViewButton()
    }
    
    
    // MARK: - Function
    func setAttribute() {
        customTitleView()
        
        goalRoutineTextField.layer.borderColor = UIColor.blueGray3.cgColor
        goalRoutineTextField.layer.borderWidth = 1
        goalRoutineTextField.layer.cornerRadius = 8
        goalRoutineTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        goalRoutineTextField.leftViewMode = .always
        
        setTimeButtonAttribute(for: startTimeView)
        setTimeButtonAttribute(for: goalTimeView)
    }
    
    func setTimeButtonAttribute(for view: UIView) {
        view.layer.borderColor = UIColor.blueGray3.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
    }
    
    func setFont() {
        goalRoutineLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        goalRoutineTextField.font = UIFont(name: "Pretendard-Regular", size: 16)
        repeatPeriodLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        startTimeTitleLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        startTimeLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        goalTimeTitleLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        goalTimeLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 폰트 설정
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
        
        customTitleView()
    }
    
    func customTitleView() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let containerView = UIView()
        let titleView = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "목표 루틴 설정"
        titleLabel.font = UIFont(name: "Pretendard-Regular", size: 18)
        titleLabel.textColor = .black
        
        let customButton = UIButton(type: .system)
        if let informationImage = UIImage(named: "information") {
            customButton.setImage(informationImage, for: .normal)
        }
        customButton.addTarget(self, action: #selector(customButtonDidTap), for: .touchUpInside)
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(customButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        customButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            
            customButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            customButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            customButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
        ])
        
        containerView.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            titleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        self.navigationItem.titleView = containerView
    }

    
    // MARK: - Action
    private func setWeekStackViewButton() {
        for case let button as UIButton in weekStackButton.arrangedSubviews {
            setButton(button)
        }
    }
    
    private func setButton(_ button: UIButton) {
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blueGray3.cgColor
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func completeButtonDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func customButtonDidTap(_ sender: UIButton) {
        // 커스텀 버튼 동작 추가
        print("Success.")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        UIView.performWithoutAnimation {
            if sender.isSelected {
                sender.isSelected = false
                sender.backgroundColor = UIColor.white
                sender.layer.borderColor = UIColor.blueGray4.cgColor
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
