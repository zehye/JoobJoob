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
    }
}

extension OnboardingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnboardingDescCell") as? OnboardingDescTableViewCell else {
            fatalError()
        }
        return cell
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
