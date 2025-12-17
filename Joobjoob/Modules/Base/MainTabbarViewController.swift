//
//  ViewController.swift
//  Joobjoob
//
//  Created by zehye on 12/17/25.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showHomeTab), name: .ShowHomeTab, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showCommunityTab), name: .ShowCommunityTab, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showProfileTab), name: .ShowProfileTab, object: nil)
    }
    
    @objc func showHomeTab() {
        self.selectedIndex = 1
    }
    
    @objc func showCommunityTab() {
        self.selectedIndex = 2
    }
    
    @objc func showProfileTab() {
        self.selectedIndex = 3
    }
}
