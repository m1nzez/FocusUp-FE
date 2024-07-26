//
//  MyPageViewController.swift
//  FocusUp
//
//  Created by 성호은 on 7/24/24.
//

import UIKit

class MyPageViewController: UIViewController {
    // MARK: - property
    @IBOutlet weak var settingButton: UIBarButtonItem!
    @IBOutlet weak var goalRoutineLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var addNewRoutineButton: UIButton!
    @IBOutlet weak var levelStateLabel: UILabel!
    @IBOutlet weak var levelNoticeLabel: UILabel!
    @IBOutlet weak var presentLevelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 폰트 적용
        self.goalRoutineLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.addUnderlineToMoreButton()
        self.addNewRoutineButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.levelStateLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.levelNoticeLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        self.presentLevelLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        self.addUnderlineToPresentLevelLabel()
        
        
        // addNewRoutineButton 테두리 설정
        self.addNewRoutineButton.layer.cornerRadius = 8
        self.addNewRoutineButton.layer.borderWidth = 1
        self.addNewRoutineButton.layer.borderColor = UIColor(named: "BlueGray3")?.cgColor
        
        // progressView 설정
        levelProgress.layer.cornerRadius = 5
        levelProgress.clipsToBounds = true
        levelProgress.translatesAutoresizingMaskIntoConstraints = false
        levelProgress.progress = 0.0
        self.view.addSubview(levelProgress)
        
        // 제약 조건 추가
        NSLayoutConstraint.activate([
            levelProgress.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            levelProgress.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            levelProgress.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        // 예시: 5개의 구간으로 나누어 진행 상황을 업데이트
        updateProgressView(to: 0.2) // 첫 번째 구간 (25%)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateProgressView(to: 0.4) // 두 번째 구간 (50%)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.updateProgressView(to: 0.6) // 세 번째 구간 (75%)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.updateProgressView(to: 0.8) // 네 번째 구간 (100%)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.updateProgressView(to: 1.0) // 네 번째 구간 (100%)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // 네이게이션 바 타이틀 설정
        self.navigationItem.title = "마이페이지"
        
        // 탭바 아이템 타이틀 설정
        self.tabBarItem.title = "MyPage"
        
        
        if let customFont = UIFont(name: "Pretendard-Regular", size: 18) {
            let textAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: customFont
            ]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            print("커스텀 폰트를 로드할 수 없습니다.")
        }
    
    }

    // MARK: - action
    @IBAction func didTapSettingBtn(_ sender: Any) {
        guard let toSettingVC = self.storyboard?.instantiateViewController(identifier: "SettingViewController") else { return }
        self.navigationController?.pushViewController(toSettingVC, animated: true)
    }
    
    @IBAction func didTapMoreBtn(_ sender: Any) {
        guard let toGoalRoutineListVC = self.storyboard?.instantiateViewController(identifier: "GoalRoutineListViewController") else { return }
        self.navigationController?.pushViewController(toGoalRoutineListVC, animated: true)
    }
    
    @IBAction func didTapAddNewRoutineBtn(_ sender: Any) {
        guard let toGoalRoutineSettingVC = self.storyboard?.instantiateViewController(identifier: "GoalRoutineSettingViewController") else { return }
        self.navigationController?.pushViewController(toGoalRoutineSettingVC, animated: true)
    }
    
    private func addUnderlineToMoreButton() {
        let title = "더보기"
        let font = UIFont(name: "Pretendard-Regular", size: 10)
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: font ?? .systemFont(ofSize: 10),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.black
        ])
        moreButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private func addUnderlineToPresentLevelLabel() {
        guard let title = presentLevelLabel.text else {
            return
        }
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: presentLevelLabel.font ?? UIFont.systemFont(ofSize: 12),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        presentLevelLabel.attributedText = attributedTitle
    }
    
    private func updateProgressView(to progress: Float) {
        levelProgress.setProgress(progress, animated: true)
    }

}
