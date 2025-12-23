//
//  LoginViewController.swift
//  Joobjoob
//
//  Created by zehye on 12/23/25.
//

import UIKit

class LoginViewController: UIViewController {
    static func instance() -> LoginViewController {
        let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return vc
    }
}
