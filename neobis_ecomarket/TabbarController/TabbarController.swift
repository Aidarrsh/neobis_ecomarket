//
//  TabbarController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 1/11/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    let customButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.frame.size.height = 83
        tabBar.tintColor = UIColor(hex: "#75DB1B")
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor.gray.cgColor
        tabBar.layer.borderWidth = 0.19
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let vc1 = MainViewController()
        
        vc1.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "homeTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        let vc2 = BagViewController()
        
        vc2.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "bagTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        let vc3 = UIViewController()
//
        vc3.tabBarItem = UITabBarItem(title: "История", image: UIImage(named: "historyTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        let vc4 = InfoViewController()
        
        vc4.tabBarItem = UITabBarItem(title: "Инфо", image: UIImage(named: "infoTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        viewControllers = [vc1, vc2, vc3, vc4]
    }

    func createVC(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(named: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        
        let vc1 = UINavigationController(rootViewController: vc)
        vc1.tabBarItem = item
        
        return vc1
    }
}
