//
//  LoginViewController.swift
//  Joobjoob
//
//  Created by zehye on 12/23/25.
//

import UIKit

class LoginViewController: UIViewController {
    static func instance() -> LoginViewController {
        let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return vc
    }
    
    @IBOutlet weak var appNameLbl: UILabel!
    @IBOutlet weak var loginDescLbl: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var kakaoLoginView: LoginView!
    @IBOutlet weak var naverLoginView: LoginView!
    @IBOutlet weak var appleLoginView: LoginView!
    @IBOutlet weak var googleLoginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        kakaoLoginView.configure(type: .kakao)
        naverLoginView.configure(type: .naver)
        appleLoginView.configure(type: .apple)
        googleLoginView.configure(type: .google)
        
        kakaoLoginView.delegate = self
        naverLoginView.delegate = self
        appleLoginView.delegate = self
        googleLoginView.delegate = self
    }
    
    func initUI() {
        self.loginDescLbl.font = UIFont.spoqaHanSansNeo(type: .medium, size: CGFloat(12))
        self.loginDescLbl.textColor = ColorTheme(background: .grey)
        self.loginDescLbl.text = "LOGIN_SNS".localized
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginViewDidTap(_ view: LoginView, type: Platform) {
        switch type {
        case .kakao:
            print("카카오 로그인")
        case .naver:
            print("네이버 로그인")
        case .apple:
            print("애플 로그인")
        case .google:
            print("구글 로그인")
        }
    }
}
