//
//  OnboardingProfileImageTableViewCell.swift
//  Joobjoob
//
//  Created by zehye on 1/3/26.
//

import UIKit

class OnboardingProfileImageTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    func initUI() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        
//        self.cameraBtn. = UIImage(named: "icCamera")?.withRenderingMode(.alwaysOriginal)
        self.cameraBtn.layer.cornerRadius = self.cameraBtn.frame.height / 2
    }
    
}
