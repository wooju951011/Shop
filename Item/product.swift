//
//  product.swift
//  Shop
//
//  Created by wooju on 2022/12/12.
//

import Foundation

struct product: Decodable {
    let topPrimaryNumber: Int
    let topName: String
    let topPrice: Int
    let stock: Int
    let description: String
    let imageURL: String
    let category: String

    enum CodingKeys: String, CodingKey {
        case topPrimaryNumber = "pk"
        case topName = "name"
        case topPrice = "price"
        case stock
        case description
        case imageURL = "image"
        case category
    }
}
