//
//  BaseTargetType.swift
//  Shop
//
//  Created by wooju on 2023/01/02.
//

import Moya

protocol BaseTargetType : TargetType { }

extension BaseTargetType {
    public var baseURL: URL {
        URL(string: "http://192.168.55.201:8000")!
    }
}
