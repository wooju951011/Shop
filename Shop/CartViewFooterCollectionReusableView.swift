//
//  CartViewFooterCollectionReusableView.swift
//  Shop
//
//
//  CartViewFooterCollectionReusableView.swift
//  example
//
//  Created by wooju on 2023/01/05.
//

import UIKit

final class CartViewFooterCollectionReusableView: UICollectionReusableView {

    private let divideLine = UIView().then {
        $0.backgroundColor = .darkGray
    }

    private let totalPriceTitleLabel = UILabel().then {
        $0.text = "총 상품금액"
    }

    lazy var priceNumberLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .red
        $0.textAlignment = .right
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func render() {
        addSubview(divideLine)
        addSubview(totalPriceTitleLabel)
        addSubview(priceNumberLabel)

        divideLine.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        totalPriceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }

        priceNumberLabel.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).inset(-15)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(150)
            $0.height.equalTo(20)
        }
    }

    func setupCartFooter(_ items: Cart) {
        self.priceNumberLabel.text = String(items.totalBill)
    }
}
