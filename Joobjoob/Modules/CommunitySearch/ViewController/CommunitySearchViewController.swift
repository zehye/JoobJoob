//
//  CommunitySearchViewController.swift
//  Joobjoob
//
//  Created by zehye on 1/2/26.
//


import UIKit

class CommunitySearchViewController: UIViewController {
    static func instance() -> CommunitySearchViewController {
        UIStoryboard(name: "CommunitySearch", bundle: nil)
            .instantiateViewController(withIdentifier: "CommunitySearchViewController") as! CommunitySearchViewController
    }
}
