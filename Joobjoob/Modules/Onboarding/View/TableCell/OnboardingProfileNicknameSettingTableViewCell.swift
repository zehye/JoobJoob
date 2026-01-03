//
//  OnboardingProfileNicknameSettingTableViewCell.swift
//  Joobjoob
//
//  Created by zehye on 1/3/26.
//

import UIKit

class OnboardingProfileNicknameSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var duplicateBtn: UIButton!
    
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    func initUI() {
        self.nicknameTextField.backgroundColor = ColorTheme(background: .white)
        self.nicknameTextField.layer.borderColor = ColorTheme(foreground: .grey).cgColor
        self.nicknameTextField.layer.borderWidth = 1
        self.nicknameTextField.layer.cornerRadius = 10
        self.nicknameTextField.borderStyle = .none
        
        let placeholder = "".localized
        let arrtibutedString = NSMutableAttributedString(string: placeholder, attributes: [NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(type: .medium, size: 14) as Any, NSAttributedString.Key.foregroundColor: ColorTheme(background: .grey)])
        
        self.nicknameTextField.attributedPlaceholder = arrtibutedString
        
        self.duplicateBtn.setTitle("DUPLICATE_CONFIRMATION".localized, for: .normal)
        self.duplicateBtn.titleLabel?.font = UIFont.spoqaHanSansNeo(type: .bold, size: CGFloat(14))
        self.duplicateBtn.tintColor = ColorTheme(foreground: .white)
        self.duplicateBtn.layer.cornerRadius = 5
        self.duplicateBtn.backgroundColor = ColorTheme(background: .grey)
        
        self.descLbl.text = "NICKNAME_CONDITION".localized
        self.descLbl.textColor = ColorTheme(foreground: .black)
        self.descLbl.font = UIFont.spoqaHanSansNeo(type: .medium, size: CGFloat(10))
    }
}
