//
//  OnboardingViewController.swift
//  Joobjoob
//
//  Created by zehye on 1/2/26.
//

import UIKit

class OnboardingViewController: UIViewController {
    static func instance() -> OnboardingViewController {
        UIStoryboard(name: "Onboarding", bundle: nil)
            .instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
    }
    @IBOutlet weak var navigationView: NavigationView!
    
    @IBOutlet weak var descContainerView: UIView!
    @IBOutlet weak var descTitleLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: BottomButtonView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.tableView.reloadData()
    }
    
    func initUI() {
        self.navigationView.delegate = self
        self.navigationView.leftBtn.isHidden = false
        self.navigationView.titleLbl.text = "JOOBJOOB".localized
        
        self.descTitleLbl.text = "ONBOARDING_DESC_TITLE".localized
        self.descTitleLbl.textColor = ColorTheme(foreground: .black)
        self.descTitleLbl.font = UIFont.spoqaHanSansNeo(type: .medium, size: CGFloat(14))
        self.descTitleLbl.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: self.descTitleLbl.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
    
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        self.descTitleLbl.attributedText = attrString
        
        self.bottomView.button.setTitle("GO_JOOBJOOB".localized, for: .normal)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        self.tableView.register(UINib(nibName: "OnboardingTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "OnboardingTitleCell")
        self.tableView.register(UINib(nibName: "OnboardingProfileImageTableViewCell", bundle: nil), forCellReuseIdentifier: "OnboardingProfileImageCell")
        self.tableView.register(UINib(nibName: "OnboardingProfileNicknameSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "OnboardingProfileNicknameCell")
        self.tableView.register(UINib(nibName: "OnboardingProfileRegionSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "OnboardingProfileRegionCell")
        self.tableView.register(UINib(nibName: "OnboardingProfileCategorySettingTableViewCell", bundle: nil), forCellReuseIdentifier: "OnboardingProfileCategoryCell")
    }
}

extension OnboardingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnboardingTitleCell") as? OnboardingTitleTableViewCell else {
                    fatalError()
                }
                cell.titleLbl.text = "PROFILE_SETTING".localized
                cell.descLbl.isHidden = true
                
                return cell
            } else if row == 1 {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnboardingProfileImageCell") as? OnboardingProfileImageTableViewCell else {
                    fatalError()
                }
                
                return cell
            } else {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnboardingProfileNicknameCell") as? OnboardingProfileNicknameSettingTableViewCell else {
                    fatalError()
                }
                
                return cell
            }
        } else if section == 1 {
            if row == 0 {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnboardingTitleCell") as? OnboardingTitleTableViewCell else {
                    fatalError()
                }
                cell.titleLbl.text = "REGION_SETTING".localized
                cell.descLbl.text = "SELECT_REGION".localized
                
                return cell
            } else {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnboardingProfileRegionCell") as? OnboardingProfileRegionSettingTableViewCell else {
                    fatalError()
                }
                return cell
            }
        } else {
            if row == 0 {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnboardingTitleCell") as? OnboardingTitleTableViewCell else {
                    fatalError()
                }
                cell.titleLbl.text = "FAVORITE_ACTION".localized
                cell.descLbl.text = "FAVORITE_CONDITION".localized
                
                return cell
            }
            else {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnboardingProfileCategoryCell") as? OnboardingProfileCategorySettingTableViewCell else {
                    fatalError()
                }
                return cell
            }
        }
    }
    
    
}

extension OnboardingViewController: NavigationViewDelegate {
    func leftBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightBtnClicked() {
        let vc = CommunitySearchViewController.instance()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func rightSecondBtnClicked() {
        let vc = CommunitySearchViewController.instance()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
