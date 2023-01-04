//
//  KeyChainHandler.swift
//  Shop
//
//  Created by wooju on 2023/01/02.
//

import SwiftKeychainWrapper

struct KeychainHandler {
    static var shared = KeychainHandler()
    private init() {}
    
    private let keychain = KeychainWrapper.standard
    private let accessTokenKey = "accessToken"
    private let nicknameKey = "userNickname"
    private let emailKey = "emailID"
    
    var accessToken: String {
        get {
            return keychain.string(forKey: accessTokenKey) ?? ""
        }
        set {
            keychain.set(newValue, forKey: accessTokenKey)
        }
    }
    
    var nickname: String {
        get {
            return keychain.string(forKey: nicknameKey) ?? ""
        }
        set {
            keychain.set(newValue, forKey: nicknameKey)
        }
    }
    
    var emailID: String {
        get {
            return keychain.string(forKey: emailKey) ?? ""
        }
        set {
            keychain.set(newValue, forKey: emailKey)
        }
    }
}
