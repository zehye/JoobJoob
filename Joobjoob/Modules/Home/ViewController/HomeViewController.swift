//
//  HomeViewController.swift
//  Joobjoob
//
//  Created by zehye on 12/17/25.
//

import UIKit

class HomeViewController: UIViewController {
    static func instance() -> HomeViewController {
        UIStoryboard(name: "Home", bundle: nil)
            .instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
}
