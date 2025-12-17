//
//  ProfileViewController.swift
//  Joobjoob
//
//  Created by zehye on 12/17/25.
//

import UIKit

class ProfileViewController: UIViewController {
    static func instance() -> ProfileViewController {
        let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        return vc
    }
}
