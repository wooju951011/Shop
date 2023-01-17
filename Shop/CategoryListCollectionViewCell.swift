//
//  CategoryListCollectionViewCell.swift
//  Shop
//
//  Created by wooju on 2023/01/17.
//

import UIKit

final class CategoryListCollectionViewCell: UICollectionViewCell {

    lazy var itemImageView = UIImageView().then {
       //$0.image = UIImage(url: "itemDetailCategory")
        $0.contentMode = .scaleToFill
    }

    lazy var nameLabel = UILabel().then {
        $0.text = "21WN"
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.2
        $0.numberOfLines = 1
    }

    lazy var descriptionLabel = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }

    lazy var priceLabel = UILabel().then {
        $0.text = "98,000"
        $0.textColor = .orange
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ items: product) {
        self.itemImageView.load(url: URL(string: items.imageURL)!)
        self.nameLabel.text = items.topName
        self.priceLabel.text = String(items.topPrice)
    }

    private func render() {
        self.backgroundColor = .white
        contentView.addSubview(itemImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)

        itemImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(4)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(4)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-4)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview()
        }
    }
    
}
