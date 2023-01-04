//
//  Link.swift
//  Shop
//
//  Created by wooju on 2023/01/02.
//


import Moya

enum Link: BaseTargetType {
    case getItemList
    case getItemDetail(itemID: Int)
    case putItemToCart(itemID: Int,quantity: Int)
    case getCartList
    case signUp(email: String, password: Int, nickname: String)
    case login(email: String, password: Int)
}

extension Link: TargetType {
    var path: String{
        switch self{
        case .getItemList:
            return "/product/list"
        case .getItemDetail(let itemID):
            return "/product/list/\(itemID)/"
        case .putItemToCart:
            return "/order/cartview/"
        case .getCartList:
            return "/order/cartview/"
        case .signUp:
            return "/user/register2/"
        case .login:
            return "/user/auth/"
        }
    }
    var method: Moya.Method {
        switch self{
        case .getItemList:
            return .get
        case .getItemDetail:
            return .get
        case .putItemToCart:
            return .post
        case .getCartList:
            return .get
        case .signUp:
            return .post
        case .login:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .getItemList:
            return .requestPlain
        case .getItemDetail:
            return .requestPlain
        case .putItemToCart(let itemID,let quantity):
            let parameters: [String: Int] = [
                "product.id": itemID,
                "quantity": quantity
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getCartList:
            return .requestPlain
        case .signUp(let email, password: let password, nickname: let nickname):
            let parameters: [String: Any] = [
                "email": email,
                "password": password,
                "nickname": nickname
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .login(let email, let password):
            let parameters: [String: Any] = [
                "email": email,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding:     JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        default:
            return ["Authorization": "Bearer " + KeychainHandler.shared.accessToken]
        }
    }
}
