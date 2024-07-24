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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 폰트 적용
        self.goalRoutineLabel.font = UIFont(name: "Pretendard-Medium.otf", size: 15)
        self.addUnderlineToMoreButton()
        self.addNewRoutineButton.titleLabel?.font = UIFont(name: "Pretandard-Medium.otf", size: 15)
        
        // addNewRoutineButton 테두리 설정
        self.addNewRoutineButton.layer.cornerRadius = 8
        self.addNewRoutineButton.layer.borderWidth = 1
        self.addNewRoutineButton.layer.borderColor = UIColor(named: "BlueGray3")?.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "마이페이지"
        
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
    
    
    
    
    private func addUnderlineToMoreButton() {
        let title = "더보기"
        let font = UIFont(name: "Pretandard-Regular", size: 10)
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: font ?? .systemFont(ofSize: 10),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.black
        ])
        moreButton.setAttributedTitle(attributedTitle, for: .normal)
    }

}
