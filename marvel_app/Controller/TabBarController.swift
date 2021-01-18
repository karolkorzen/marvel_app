//
//  TabBarController.swift
//  marvel_app
//
//  Created by Karol Korzeń on 14/01/2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Helpers

    func configureUI(){
        view.backgroundColor = .white
        view.tintColor = UIColor.rgb(red: 243, green: 51, blue: 53)
        tabBar.isTranslucent = false
        tabBar.layer.borderWidth = 0.50
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.clipsToBounds = true
        tabBar.unselectedItemTintColor = UIColor.rgb(red: 177, green: 177, blue: 177)
    }
    
    func configureViewControllers(){
        
        let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        let navHome = templateNavigationController(image: UIImage(named: "home_icon")!, rootViewController: homeController)
        
        let searchController = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        let navSearch = templateNavigationController(image: UIImage(named: "search_icon")!, rootViewController: searchController)
        
        viewControllers = [navHome, navSearch]
    }

    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        return nav
    }
}

