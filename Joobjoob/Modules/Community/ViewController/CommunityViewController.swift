//
//  CommunityViewController.swift
//  Joobjoob
//
//  Created by zehye on 12/17/25.
//

import UIKit

class CommunityViewController: UIViewController {
    static func instance() -> CommunityViewController {
        let vc = UIStoryboard.init(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityViewController") as! CommunityViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
