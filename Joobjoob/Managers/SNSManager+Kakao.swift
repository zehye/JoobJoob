//
//  SNSManager+Kakao.swift
//  Joobjoob
//
//  Created by zehye on 12/27/25.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

extension SNSManager.Kakao {
    func initalize() {
        guard let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String else {
            fatalError("KAKAO_APP_KEY not found in Info.plist")
        }
        
        KakaoSDK.initSDK(appKey: kakaoAppKey)
    }
    
    func isAuthenticationRedirectURL(_ url: URL) -> Bool {
        AuthApi.isKakaoTalkLoginUrl(url) && AuthController.handleOpenUrl(url: url)
    }
    
    func login() async throws {
        let token = UserApi.isKakaoTalkLoginAvailable()
        ? try await loginWithKakaoTalk()
        : try await loginWithKakaoAccount()
        
        try await getUserProfile(token)
    }
    
    func logout() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.logout { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                } else {
                    // 디바이스에 저장된 정보 삭제
                    KeychainManager.delete(key: "account")
                    
                    continuation.resume()
                }
            }
        }
    }
    
    @discardableResult
    func unlink() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.unlink { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                } else {
                    // 서버에 회원탈퇴 요청
                    // ..
                    
                    // 디바이스에 저장된 정보 삭제
                    KeychainManager.delete(key: "account")
                    
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    private func loginWithKakaoTalk() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk(nonce: nil) { (oauthToken, error) in
                if let error = error {
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                } else if let oauthToken {
                    continuation.resume(returning: oauthToken)
                }
            }
        }
    }
    
    @MainActor
    private func loginWithKakaoAccount() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                } else if let oauthToken {
                    continuation.resume(returning: oauthToken)
                }
            }
        }
    }
    
    private func getUserProfile(_ token: OAuthToken) async throws {
        guard AuthApi.hasToken() else { return }
        
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.me() { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                } else if let user {
                    guard let userIdentifier = user.id else { return }
                    
                    let identityToken = token.idToken
                    let account = Account(platform: .kakao, id: String(userIdentifier))
                    
                    guard let data = try? JSONEncoder().encode(account),
                          let jsonString = String(data: data, encoding: .utf8) else { return }
                    
                    KeychainManager.write(key: "account", value: jsonString)
                    
                    // 서버에 identityToken 전달
                    // ..
                    
                    continuation.resume()
                }
            }
        }
    }
}
