//
//  CategoryMenuCollectionViewCell.swift
//  Shop
//
//  Created by wooju on 2023/01/17.
//

import UIKit

protocol CategoryMenuDetailDelegate: AnyObject {
    func goToCategoryDetail(_ collectionViewCell: UICollectionViewCell)
}

final class CategoryMenuCollectionViewCell: UICollectionViewCell {

    public weak var delegate: CategoryMenuDetailDelegate?

    lazy var categoryNameLabel = UILabel().then {
        $0.text = "상의"
    }

    private let forwardImageView = UIImageView().then {
        $0.image = UIImage(named: "Forward")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(forwardImageView)

        categoryNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(100)
        }

        forwardImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
}
