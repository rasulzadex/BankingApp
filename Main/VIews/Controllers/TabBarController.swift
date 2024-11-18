//
//  TestVC.swift
//  BankAPP
//
//  Created by Javidan on 05.11.24.
//

import UIKit


import UIKit

class TabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
                setupTabBar()
        UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 2)
            
    }
    

    private func setupTabBar() {
       
        self.tabBar.tintColor = .appGreen
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.layer.borderWidth = 0
        self.tabBar.layer.borderColor = UIColor.appGreen.withAlphaComponent(0.5).cgColor
        self.tabBar.layer.cornerRadius = 10
        self.tabBar.backgroundColor = .gray.withAlphaComponent(0.1)
    
        let firstTab = CardController()
        firstTab.view.backgroundColor = .clear
        firstTab.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeTab")?.resize(to: CGSize(width: 25, height: 25)), tag: 0)
       

        let secondTab = TransferController()
        secondTab.view.backgroundColor = .red
        secondTab.tabBarItem = UITabBarItem(title: "Transfer", image: UIImage(named: "transferTab")?.resize(to: CGSize(width: 25, height: 25)), tag: 1)
        
        
        let thirdTab = ProfileController()
        thirdTab.view.backgroundColor = .red
        thirdTab.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 2)
        
        
        viewControllers = [firstTab, secondTab, thirdTab]
    }
}

