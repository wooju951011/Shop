//
//  user.swift
//  Shop
//
//  Created by wooju on 2023/01/02.
//

struct UserInfo: Decodable {
    let user: LoginInfo
    let message: String
    let token: TokenInfo
}

struct LoginInfo: Decodable {
    let email: String
    let nickname: String
}

struct TokenInfo: Decodable {
    let access: String
    let refresh: String
}
