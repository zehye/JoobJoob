//
//  SNSManager.swift
//  Joobjoob
//
//  Created by zehye on 12/27/25.
//

import Foundation
import UIKit
import AuthenticationServices
import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth
import CryptoKit
import Firebase
import FirebaseAuth

protocol SNSManagerDelegate: AnyObject {
    var snsManagerViewController: UIViewController { get }
    func snsManager(_ type: SNSManager.SNSType, error: Error?)
    func snsManager(_ type: SNSManager.SNSType, login: SNSManager.SNSUser)
    func snsManagerDisconnect(_ type: SNSManager.SNSType)
}

extension SNSManagerDelegate {
    func snsManagerDisconnect(_ type: SNSManager.SNSType) { }
}

final class SNSManager: NSObject {
    static func instance(delegate: SNSManagerDelegate?) -> SNSManager {
        let instance = SNSManager()
        instance.delegate = delegate
        return instance
    }
    
    weak var delegate: SNSManagerDelegate?
    
    fileprivate var currentNonce: String?
    
    override init() {
        
    }
    
    func kakao() {
        UserApi.shared.loginWithKakaoAccount(prompts: [.Login], completion: { [weak self] (_, error) in
            if let error = error {
                self?.delegate?.snsManager(.kakao, error: error)
                return
            }
            UserApi.shared.me(completion: { [weak self] (user, error) in
                guard let user = user else {
                    self?.delegate?.snsManager(.kakao, error: error)
                    return
                }
                var scopes = [String]()
                if user.kakaoAccount?.profileNeedsAgreement == true { scopes.append("profile") }
                if user.kakaoAccount?.emailNeedsAgreement == true { scopes.append("account_email") }
                if user.kakaoAccount?.birthdayNeedsAgreement == true { scopes.append("birthday") }
                if user.kakaoAccount?.birthyearNeedsAgreement == true { scopes.append("birthyear") }
                if user.kakaoAccount?.genderNeedsAgreement == true { scopes.append("gender") }
                UserApi.shared.loginWithKakaoAccount(scopes: scopes, completion: { [weak self] (_, error) in
                    if let error = error {
                        self?.delegate?.snsManager(.kakao, error: error)
                        return
                    }
                    UserApi.shared.me(completion: { [weak self] (user, error) in
                        guard let user = user else {
                            self?.delegate?.snsManager(.kakao, error: error)
                            return
                        }
                        var login = SNSUser(.kakao)
                        login.token = "\(user.id ?? 0)"
                        login.name = user.kakaoAccount?.legalName
                        if login.name == nil || login.name == "" {
                            login.name = user.properties?["nickname"]
                        }
                        if login.name == nil || login.name == "" {
                            login.name = user.kakaoAccount?.profile?.nickname
                        }
//                        login.gender = user.kakaoAccount?.gender == .Male ? .male : .female
                        login.email = user.kakaoAccount?.email
                        login.profile = user.kakaoAccount?.profile?.profileImageUrl?.absoluteString
                        login.thumbnail = user.kakaoAccount?.profile?.thumbnailImageUrl?.absoluteString
                        self?.delegate?.snsManager(.kakao, login: SNSUser.kakao(login))
                    })
                })
            })
        })
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
}


// MARK: ASAuthorizationControllerPresentationContextProviding
extension SNSManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
//
//// MARK: ASAuthorizationControllerDelegate
//extension SNSManager: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let crediential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let nonce = self.currentNonce else {
//                fatalError("Invalid state: A login callback was received, but no login request was sent.")
//            }
//            guard let appleIDToken = crediential.identityToken else {
//                print("Unable to fetch identity token")
//                return
//            }
//            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//                return
//            }
//            
//            let token = crediential.user
//            var email = crediential.email
//            let givenName = crediential.fullName?.givenName
//            let familyName = crediential.fullName?.familyName
//            var name = "\(familyName ?? "")\(givenName ?? "")"
//            
//            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
//            // Sign in with Firebase.
//            Auth.auth().signIn(with: credential) { (authResult, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//                if let userEmail = authResult?.user.email, userEmail != "" {
//                    email = userEmail
//                }
//                if let userName = authResult?.user.displayName, userName != "" {
//                    name = userName
//                }
//                var appleLogins = StandardDataManager.appleDictionary[.appleLogin] ?? [String: [String: AnyObject]]()
//                if appleLogins[token] == nil {
//                    appleLogins[token] = [String: AnyObject]()
//                }
//                if let email = email {
//                    appleLogins[token]?.updateValue(email as AnyObject, forKey: "email")
//                }
//                if name != "" {
//                    appleLogins[token]?.updateValue(name as AnyObject, forKey: "name")
//                }
//                StandardDataManager.appleDictionary[.appleLogin] = appleLogins
//                self.delegate?.snsManager(.apple, login: SNSUser.apple(crediential.user))
//            }
//        } else if let crediential = authorization.credential as? ASPasswordCredential {
//            self.delegate?.snsManager(.apple, login: SNSUser.apple(crediential.user))
//        } else {
//            self.delegate?.snsManager(.apple, error: nil)
//        }
//    }
//    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        self.delegate?.snsManager(.apple, error: error)
//    }
//}

extension SNSManager {
    enum SNSType: String {
        case kakao = "k"
        case naver = "n"
        case apple = "a"
        case google = "g"
        
        var analytics: String {
            switch self {
            case .kakao: return "kakao"
            case .naver: return "naver"
            case .apple: return "apple"
            case .google: return "google"
            }
        }
        
        var typeValue: String? {
            if self == .kakao {
                return AccountType.kakao.rawValue
            } else if self == .naver {
                return AccountType.naver.rawValue
            } else if self == .apple {
                return AccountType.apple.rawValue
            } else if self == .google {
                return AccountType.google.rawValue
            }
            return nil
        }
        
        var requestType: AccountType? {
            if self == .kakao {
                return AccountType.kakao
            } else if self == .naver {
                return AccountType.naver
            } else if self == .apple {
                return AccountType.apple
            } else if self == .google {
                return AccountType.google
            }
            return nil
        }
    }
    
    struct SNSUser {
        var type: SNSType
        var email: String?
        var name: String?
        var token: String?
//        var gender: UserManager.GenderType?
        var birthday: Date?
        var profile: String?
        var thumbnail: String?
        
        init(_ type: SNSType) {
            self.type = type
        }
        
        init(_ type: SNSType, email: String, name: String, token: String, birthday: Date?, profile: String, thumbnail: String) {
            self.type = type
            self.email = email
            self.name = name
            self.token = token
//            self.gender = gender
            self.birthday = birthday
            self.profile = profile
            self.thumbnail = thumbnail
        }
        
       
        
        static func kakao(_ login: SNSUser) -> SNSUser {
            return login
        }
    }
}
