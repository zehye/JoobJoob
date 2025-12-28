//
//  LoginView.swift
//  Joobjoob
//
//  Created by zehye on 12/26/25.
//

import UIKit

//enum LoginType {
//    case kakao
//    case naver
//    case apple
//    case google
//}

protocol LoginViewDelegate: AnyObject {
    func loginViewDidTap(_ view: LoginView, type: Platform)
}

class LoginView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerBtn: UIButton!
    
    @IBOutlet weak var loginImgView: UIImageView!
    @IBOutlet weak var loginTitleLbl: UILabel!
    
    weak var delegate: LoginViewDelegate?
//    private var loginType: LoginType?
    
//    var platforms: [Platform] = Platform.allCases
    var platformstype: Platform?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "LoginView", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)

        guard let view = objects.first(where: { $0 is UIView }) as? UIView else {
            fatalError("LoginView.xib root UIView not found")
        }

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func configure(type: Platform) {
        self.platformstype = type
        
        containerView.layer.cornerRadius = 4
        containerBtn.setTitle("", for: .normal)
        loginTitleLbl.font = UIFont.spoqaHanSansNeo(type: .bold, size: CGFloat(18))
        
        switch type {
        case .kakao:
            loginTitleLbl.text = "LOGIN_KAKAO".localized
            loginImgView.image = UIImage(named: "icKakao")
            containerView.backgroundColor = ColorTheme(background: .kakalYellow)
            loginTitleLbl.textColor = ColorTheme(foreground: .black)
            
        case .naver:
            loginTitleLbl.text = "LOGIN_NAVER".localized
            loginImgView.image = UIImage(named: "icNaver")
            containerView.backgroundColor = ColorTheme(background: .naverGreen)
            loginTitleLbl.textColor = ColorTheme(foreground: .white)
            
        case .apple:
            loginTitleLbl.text = "LOGIN_APPLE".localized
            loginImgView.image = UIImage(named: "icApple")
            containerView.backgroundColor = ColorTheme(background: .black)
            loginTitleLbl.textColor = ColorTheme(foreground: .white)
            
        case .google:
            loginTitleLbl.text = "LOGIN_GOOGLE".localized
            loginImgView.image = UIImage(named: "icGoogle")
            containerView.backgroundColor = ColorTheme(background: .white)
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = ColorTheme(foreground: .black).cgColor
            loginTitleLbl.textColor = ColorTheme(foreground: .black)
        }
    }
    
    @IBAction func tapLogin(_ sender: UIButton) {
        guard let type = platformstype else { return }
        delegate?.loginViewDidTap(self, type: type)
    }
}
