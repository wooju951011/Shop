//
//  TabBarController.swift
//  Shop
//
//  Created by wooju on 2023/01/09.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationItem(vc: self.selectedViewController!)
    }
    private func updateNavigationItem(vc: UIViewController) {
        switch vc {
        case is MainHomeViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "우주샵",
                handler: { }
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "bell"),
                handler: { print("--> feed tapped") }
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is MyProfileViewController:
            let titleConfig = CustomBarItemConfiguration(
            title: "내 정보",
            handler: { }
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
         
            navigationItem.leftBarButtonItem = titleItem
        case is CategoryViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "장바구니",
                handler: { }
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            navigationItem.leftBarButtonItem = titleItem
        default:
            let titleConfig = CustomBarItemConfiguration(
                title: "우주샵",
                handler: { }
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            navigationItem.leftBarButtonItem = titleItem
        }
    }
}
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigationItem(vc: viewController)
    }
}
