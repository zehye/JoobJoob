//
//  OnboardingTitleTableViewCell.swift
//  Joobjoob
//
//  Created by zehye on 1/3/26.
//

import UIKit

class OnboardingTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        initUI()
    }

    func initUI() {
        self.titleLbl.textColor = ColorTheme(foreground: .black)
        self.titleLbl.font = UIFont.spoqaHanSansNeo(type: .bold, size: CGFloat(16))
        
        self.descLbl.textColor = ColorTheme(foreground: .black)
        self.descLbl.font = UIFont.spoqaHanSansNeo(type: .medium, size: CGFloat(10))
    }
    
}
