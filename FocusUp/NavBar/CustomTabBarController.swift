//
//  CustomTabBarController.swift
//  FocusUp
//
//  Created by 김미주 on 17/07/2024.
//

import UIKit

// MARK: - CustomTabBar
class CustomTabBar: UITabBar {
    let customHeight: CGFloat = 100
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = customHeight
        return sizeThatFits
    }
}

// MARK: - CustomTabBarController
class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomTabBar()
        addBorder()
        setItemImageTint()
        setTitleFont()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setItemSpacing()
    }
    
    // MARK: - function
    func setCustomTabBar() {
        let customTabBar = CustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    func addBorder() {
        let borderLayer = CALayer()
        let borderWidth: CGFloat = 1.0
        borderLayer.backgroundColor = UIColor.blueGray2.cgColor
        borderLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: borderWidth)
        tabBar.layer.addSublayer(borderLayer)
    }
    
    func setItemImageTint() {
        tabBar.unselectedItemTintColor = UIColor.blueGray6
        tabBar.tintColor = UIColor.primary4
    }
    
    func setItemSpacing() {
        guard let items = tabBar.items else { return }
        
        for (index, item) in items.enumerated() {
            if index == 0 {
                let offset: UIOffset = UIOffset(horizontal: 15, vertical: -5)
                item.titlePositionAdjustment = offset
                
                let imageInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                item.imageInsets = imageInset
            }
            else if index == 1 {
                let imageInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -35, right: 0)
                item.imageInsets = imageInset
            }
            else {
                let offset: UIOffset = UIOffset(horizontal: -15, vertical: -5)
                item.titlePositionAdjustment = offset
                
                let imageInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                item.imageInsets = imageInset
            }
        }
    }
    
    func setTitleFont() {
        if let font = UIFont(name: "Pretendard-Medium", size: 12) {
            let attributes = [NSAttributedString.Key.font: font]
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        }
    }
    
    
}
