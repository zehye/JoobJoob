//
//  OnboardingProfileRegionSettingTableViewCell.swift
//  Joobjoob
//
//  Created by zehye on 1/3/26.
//

import UIKit

class OnboardingProfileRegionSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var r1View: UIView!
    @IBOutlet weak var r2View: UIView!
    
    @IBOutlet weak var r1Lbl: UILabel!
    @IBOutlet weak var r2Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    func initUI() {
        self.r1Lbl.text = "ADDRESS_1".localized
        self.r1Lbl.textColor = ColorTheme(foreground: .black)
        self.r1Lbl.font = UIFont.spoqaHanSansNeo(type: .medium, size: CGFloat(14))
        
        self.r2Lbl.text = "ADDRESS_2".localized
        self.r2Lbl.textColor = ColorTheme(foreground: .black)
        self.r2Lbl.font = UIFont.spoqaHanSansNeo(type: .medium, size: CGFloat(14))
    }
}
