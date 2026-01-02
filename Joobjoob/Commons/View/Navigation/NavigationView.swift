//
//  NavigationView.swift
//  Joobjoob
//
//  Created by zehye on 1/2/26.
//

import UIKit

protocol NavigationViewDelegate: AnyObject {
    func leftBtnClicked()
    func rightBtnClicked()
    func rightSecondBtnClicked()
}

/// 네비게이션 공통 - 상단 네비게이션 바 커스텀 뷰
class NavigationView: UIView {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var rightSecondBtn: UIButton!
    
    weak var delegate: NavigationViewDelegate?
    
    @IBAction func leftBtnClicked(_ sender: Any) {
        self.delegate?.leftBtnClicked()
    }
    
    @IBAction func rightBtnClicked(_ sender: Any) {
        self.delegate?.rightBtnClicked()
    }
    
    @IBAction func rightSecondBtnClicked(_ sender: Any) {
        self.delegate?.rightSecondBtnClicked()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    func initUI() {
        guard let view = Bundle.main.loadNibNamed("NavigationView", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        self.titleLbl.font = UIFont.spoqaHanSansNeo(type: .bold, size: CGFloat(22))
        self.titleLbl.textColor = ColorTheme(foreground: .black)
        
        self.leftBtn.isHidden = true
        self.leftBtn.setTitle("", for: .normal)
//        self.leftBtn.setImage(UIImage(named: "icNavigationBack")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.leftBtn.tintColor = ColorTheme(background: .black)
        
        self.rightBtn.isHidden = true
        self.rightBtn.setTitle("", for: .normal)
        self.rightBtn.setImage(UIImage(named: "icSetting")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.rightSecondBtn.isHidden = true
        self.rightSecondBtn.setTitle("", for: .normal)
        self.rightSecondBtn.setImage(UIImage(named: "icSearch")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
