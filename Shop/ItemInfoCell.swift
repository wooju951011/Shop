//
//  ItemInfoCell.swift
//  Shop
//
//  Created by wooju on 2023/01/12.
//

import UIKit

class ItemInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail.layer.cornerRadius = 10
        thumbnail.tintColor = .systemGray
    }
    
    func configure(item: product) {
        nameLabel.text = item.topName
        priceLabel.text = "\(formatNumber(item.topPrice))원"
        categoryLabel.text = item.category
        
        thumbnail.image = UIImage(named: "itemDetailImage")
    }
    
    private func formatNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
//        formatter.numberStyle = .currencyPlural
//        formatter.locale = Locale(identifier: "ko-KR")
        let result = formatter.string(from: NSNumber(integerLiteral: price)) ?? ""
        return result
    }
}
