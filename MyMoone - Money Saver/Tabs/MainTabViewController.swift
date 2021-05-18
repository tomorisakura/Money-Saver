//
//  MainTabViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewWillAppear( _ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }

    override func viewWillDisappear( _ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTabBarVIew()
    }
    
    private func initTabBarVIew() {
        self.tabBar.barTintColor = .white
        let home = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let homeTab = UINavigationController(rootViewController: home)
        let homeImage = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        let homeImageSelected = UIImage(named: "Home_Selected")?.withRenderingMode(.alwaysOriginal)
        homeTab.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: homeImageSelected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        homeTab.tabBarItem.tag = 0
        
        let dream = DreamsViewController(nibName: String(describing: DreamsViewController.self), bundle: nil)
        let dreamTab = UINavigationController(rootViewController: dream)
        let dreamImage = UIImage(named: "Favorite")?.withRenderingMode(.alwaysOriginal)
        let dreamImageSelected = UIImage(named: "Favorite_Selected")?.withRenderingMode(.alwaysOriginal)
        dreamTab.tabBarItem = UITabBarItem(title: "Dreams", image: dreamImage, selectedImage: dreamImageSelected)
        dreamTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        dreamTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        dreamTab.tabBarItem.tag = 1
        
        let profile = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        let profileTab = UINavigationController(rootViewController: profile)
        let profileImage = UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        let profileImageSelected = UIImage(named: "Profile_Selected")?.withRenderingMode(.alwaysOriginal)
        profileTab.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, selectedImage: profileImageSelected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        profileTab.tabBarItem.tag = 2
        
        self.viewControllers = [homeTab, dreamTab, profileTab]
    }

}
