//
//  Link.swift
//  Shop
//
//  Created by wooju on 2023/01/02.
//

import UIKit
import Moya

enum Link: BaseTargetType {
    case getItemList
    case getItemDetail(itemID: Int)
    case putItemToCart(itemID: Int,quantity: Int)
    case getCartList
    case signUp(email: String, password: String, nickname: String)
    case login(email: String, password: String)
    case postProfileImage(image: UIImage)
    case postBackroundImage(image: UIImage)
    case getFittedImage(cartID: Int)
    case getBackgroundlist
    case getFittedBackground(backgroundID: Int)
}

extension Link: TargetType {
    var path: String{
        switch self {
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
        case .postProfileImage:
            return "/accounts/edit/"
        case .postBackroundImage:
            return "accounts/edit2/"
        case .getFittedImage(let cartID):
            return "/accounts/imageget/\(cartID)"
        case .getBackgroundlist:
            return "/product/list2/"
        case .getFittedBackground(backgroundID: let backgroundID):
            return "/accounts/imageget2/\(backgroundID)"
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
        case .postProfileImage:
            return .post
        case .postBackroundImage:
            return .post
        case .getFittedImage:
            return .get
        case .getBackgroundlist:
            return .get
        case .getFittedBackground:
            return .get
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
        case .postProfileImage(image: let image):
            let imageData = image.jpegData(compressionQuality: 1.0)

            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData!), name: "image", fileName: "000010_0.jpg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)

        case .postBackroundImage(image: let image):
            let imageData = image.jpegData(compressionQuality: 1.0)

            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData!), name: "image", fileName: "0001_img.jpg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        case .getFittedImage:
            return .requestPlain
        case .getBackgroundlist:
            return .requestPlain
        case .getFittedBackground:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login:
            return nil
        default:
            //return ["Content-Type": "application/json",
            return ["Authorization": "Bearer "+KeychainHandler.shared.accessToken]
            
        }
    }
}
