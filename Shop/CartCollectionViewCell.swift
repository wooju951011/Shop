//
//  CartCollectionViewCell.swift
//  Shop
//
//  Created by wooju on 2023/01/16.
//

import UIKit

protocol DeleteCartItemDelegation: AnyObject {
    func deleteItem(cell: UICollectionViewCell)
}

final class CartCollectionViewCell: UICollectionViewCell {

    private var numberOfItem = 1
    weak var delegate: DeleteCartItemDelegation?

    lazy var itemImageView = UIImageView().then {
        $0.image = UIImage(named: "cartItemImage")
    }

    lazy var nameOfItem = UILabel().then {
        $0.text = "Recycle Boucle Knit"
        $0.numberOfLines = 0
        $0.textColor = .darkGray
    }

    lazy var minusButton = UIButton().then {
        $0.setImage(UIImage(named: "minusBtn"), for: .normal)
        $0.addTarget(self, action: #selector(minusClicked), for: .touchUpInside)
    }

    lazy var numberOfitemLabel = UILabel().then {
        $0.text = String(numberOfItem)
        $0.textAlignment = .center
    }

    lazy var plusButton = UIButton().then {
        $0.setImage(UIImage(named: "plusBtn"), for: .normal)
        $0.addTarget(self, action: #selector(plusClicked), for: .touchUpInside)
    }

    lazy var priceLabel = UILabel().then {
        $0.text = "20,000"
        $0.textColor = .orange
    }

    lazy var deleteItemButton = UIButton().then {
        $0.setImage(UIImage(named: "btnQuitGray"), for: .normal)
        $0.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
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
        contentView.addSubview(itemImageView)
        contentView.addSubview(nameOfItem)
        contentView.addSubview(minusButton)
        contentView.addSubview(numberOfitemLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(deleteItemButton)

        itemImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }

        nameOfItem.snp.makeConstraints {
            //$0.top.equalToSuperview().inset(7)
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(114)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }

        minusButton.snp.makeConstraints {
            $0.top.equalTo(nameOfItem.snp.bottom).inset(-12)
            $0.leading.equalToSuperview().inset(114)
            $0.size.equalTo(24)
        }

        numberOfitemLabel.snp.makeConstraints {
            $0.top.equalTo(nameOfItem.snp.bottom).inset(-12)
            $0.leading.equalToSuperview().inset(138)
            $0.width.equalTo(30)
            $0.height.equalTo(24)
        }

        plusButton.snp.makeConstraints {
            $0.top.equalTo(nameOfItem.snp.bottom).inset(-12)
            $0.leading.equalToSuperview().inset(168)
            $0.size.equalTo(24)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(plusButton.snp.bottom).inset(-12)
            //$0.bottom.equalToSuperview().inset(11)
            $0.leading.equalToSuperview().inset(114)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }

        deleteItemButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(24)
        }
    }

    func setupCart(_ items: CartInfo) {
        self.itemImageView.load(url: URL(string: items.itemImageURL)!)
        self.nameOfItem.text = items.itemName
        self.numberOfitemLabel.text = String(items.quantity)
        numberOfItem = items.quantity
        self.priceLabel.text = String(items.itemTotal)
    }

    @objc
    func minusClicked() {
        print("minusClicked")
        if numberOfitemLabel.text == "1" {
            minusButton.isEnabled = false
            print("1개 이상 구매가능합니다. 확인 팝업 띄우기")
        } else {
            numberOfItem -= 1
            numberOfitemLabel.text = String(numberOfItem)
        }
    }

    @objc
    func plusClicked() {
        minusButton.isEnabled = true
        numberOfItem += 1
        numberOfitemLabel.text = String(numberOfItem)
    }

    @objc
    func deleteBtnClicked() {
        delegate?.deleteItem(cell: self)
    }
}
