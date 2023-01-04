//
//  Extension.swift
//  Shop
//
//  Created by wooju on 2023/01/04.
//

import Foundation
import UIKit
import WebKit

extension UIViewController {
    func loadWebPage(_ webView: WKWebView,_ url: String) {
        //상수 myUrl은 url 값을 받아 URL형으로 선언합니다.
        let myUrl = URL(string: url)
        //상수 myRequest는 상수 myUrl을 받아 URLRequest형으로 선언합니다.
        let myRequest = URLRequest(url: myUrl!)
        //UIWebView형의 myWebView 클래스의 loadRequest 메서드를 호출합니다.
        webView.load(myRequest)
    }
}
