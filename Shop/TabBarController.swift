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
        print(KeychainHandler.shared.nickname)
        print(KeychainHandler.shared.emailID)
        print(KeychainHandler.shared.accessToken)
        
        let mainHomeVC = UINavigationController(rootViewController: MainHomeViewController())
        mainHomeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "btnHomeMaintabNormal"), selectedImage: UIImage(named: "btnHomeMaintabPressed"))
        
        let myProfileVC = UINavigationController(rootViewController: MyProfileViewController())
        myProfileVC.tabBarItem = UITabBarItem(title: "My", image: UIImage(named: "btnMypageMaintabNormal"), selectedImage: UIImage(named: "btnMypageMaintabPressed"))
        
        self.setViewControllers([mainHomeVC,
                                 myProfileVC],
                                animated: true)
    }
}
    

