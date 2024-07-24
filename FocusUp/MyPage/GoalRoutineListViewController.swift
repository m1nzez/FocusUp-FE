//
//  GoalRoutineListViewController.swift
//  FocusUp
//
//  Created by 성호은 on 7/24/24.
//

import UIKit

class GoalRoutineListViewController: UIViewController {
    // MARK: - property

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "목표 루틴 리스트"
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
    }
    
    // MARK: - action
    @objc func completeButtonDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}
