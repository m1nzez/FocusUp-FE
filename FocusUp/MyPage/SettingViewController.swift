//
//  SettingViewController.swift
//  FocusUp
//
//  Created by 성호은 on 7/24/24.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: - property
    @IBOutlet weak var levelManageButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "설정"
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
    @IBAction func didTapLogOutBtn(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: "", preferredStyle: .alert)
        
        let Cancel = UIAlertAction(title: "취소", style: .default, handler: { (action) -> Void in})
        alert.addAction(Cancel)
        Cancel.setValue(UIColor(named: "BlueGray7"), forKey: "titleTextColor")
        
        let logout = UIAlertAction(title: "로그아웃", style: .default, handler: { (action) -> Void in})
        alert.addAction(logout)
        logout.setValue(UIColor(named: "Primary4"), forKey: "titleTextColor")
        
        alert.preferredAction = logout
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func completeButtonDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
