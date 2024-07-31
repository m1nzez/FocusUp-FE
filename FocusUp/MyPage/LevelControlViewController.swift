//
//  LevelControlViewController.swift
//  FocusUp
//
//  Created by 성호은 on 7/31/24.
//

import UIKit

class LevelControlViewController: UIViewController {
    
    private var userLevel: Int = 3 // 유저의 레벨을 설정(추후 변경)

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // 하단 보더 추가
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor(named: "BlueGray4")?.cgColor // 보더 색상 설정
        bottomBorder.frame = CGRect(x: 0, y: 56, width: UIScreen.main.bounds.width, height: 1) // 보더의 위치 및 두께 설정
        view.layer.addSublayer(bottomBorder)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 16)
        cancelButton.setTitleColor(UIColor(named: "BlueGray7"), for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        
        let completeButton = UIButton(type: .system)
        completeButton.setTitle("완료", for: .normal)
        completeButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 16)
        completeButton.setTitleColor(UIColor(named: "Primary4"), for: .normal)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(completeButton)
        
        let levelLabel = UILabel()
        levelLabel.font = UIFont(name: "Pretendard-Regular", size: 15)
        levelLabel.textColor = UIColor.black
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(levelLabel)
        
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            levelLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            levelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        setupLevelButtons()
        
        if let levelLabel = headerView.subviews.compactMap({ $0 as? UILabel }).first {
            let levelText = "My Level : \(userLevel)"
            
            // 문자열에 밑줄을 추가하는 속성 설정
            let attributedString = NSMutableAttributedString(string: levelText)
            
            // 기본 글꼴과 색상
            let font = UIFont(name: "Pretendard-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
            let textColor = UIColor.black
            let underlineStyle = NSUnderlineStyle.single.rawValue
            
            // 전체 텍스트에 속성 적용
            attributedString.addAttributes([
                .font: font,
                .foregroundColor: textColor,
                .underlineStyle: underlineStyle,
                .baselineOffset: 3.8 // 조정이 필요할 경우, 적절한 값으로 수정
            ], range: NSRange(location: 0, length: levelText.count))
            
            levelLabel.attributedText = attributedString
        }

    }
    
    private func setupUI() {
        view.addSubview(headerView)
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 57), // 헤더 높이 설정
            
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLevelButtons() {
        let myLevelButton = createButton(withTitle: "My Level")
        contentView.addSubview(myLevelButton)
        
        NSLayoutConstraint.activate([
            myLevelButton.widthAnchor.constraint(equalToConstant: 342),
            myLevelButton.heightAnchor.constraint(equalToConstant: 51),
            myLevelButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            myLevelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        var previousButton: UIButton = myLevelButton
        
        for level in 1..<userLevel {
            let levelButton = createButton(withTitle: "Level \(level)")
            contentView.addSubview(levelButton)
            
            NSLayoutConstraint.activate([
                levelButton.widthAnchor.constraint(equalToConstant: 342),
                levelButton.heightAnchor.constraint(equalToConstant: 51),
                levelButton.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 12),
                levelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
            
            previousButton = levelButton
        }
    }

    private func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(systemName: "square"))
        imageView.tintColor = UIColor(red: 0.89, green: 0.9, blue: 0.9, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
        button.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "BlueGray3")?.cgColor
        
        // Check 이미지 추가
        let checkImageView = UIImageView(image: UIImage(named: "check"))
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.isHidden = true // 기본적으로 숨겨진 상태
        button.addSubview(checkImageView)
        
        // Check 이미지 Constraints
        NSLayoutConstraint.activate([
            checkImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            checkImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            checkImageView.widthAnchor.constraint(equalToConstant: 15),
            checkImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        // 버튼 클릭 시 상태 변경
        if let checkImageView = sender.subviews.compactMap({ $0 as? UIImageView }).last {
            checkImageView.isHidden.toggle()
        }
    }
}


