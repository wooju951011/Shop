//
//  Cart.swift
//  Shop
//
//  Created by wooju on 2022/12/27.
//

import Foundation

struct Cart: Decodable {
    let data: [CartInfo]
    let totalBill: Int

    enum CodingKeys: String, CodingKey {
        case data
        case totalBill = "total_bill"
    }
}

struct CartInfo: Decodable {
    let cartID: Int
    let itemName: String
    let itemImageURL: String
    let price: Int
    let quantity: Int
    let itemTotal: Int

    enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
        case itemName = "product_name"
        case itemImageURL = "product_image_url"
        case price
        case quantity
        case itemTotal = "item_total"
    }
}

