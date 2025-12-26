//
//  SplashViewController.swift
//  Joobjoob
//
//  Created by zehye on 12/23/25.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.showLoginVC()
        }
    }
    
    func showLoginVC() {
        guard let window = SceneDelegate.shared?.window else { return }
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
//    func showExperVC() {
//        guard let window = SceneDelegate.shared?.window else { return }
//        let storyboard = UIStoryboard.init(name: "Expert", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController()
//        window.rootViewController = vc
//        window.makeKeyAndVisible()
//    }
}
