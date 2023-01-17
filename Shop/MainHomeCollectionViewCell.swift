

import UIKit

final class MainHomeCollectionViewCell: UICollectionViewCell {

    private lazy var cellImgeView = UIImageView().then {
        $0.image = UIImage(named: "justForYou")
    }

    private lazy var nameLabel = UILabel().then {
        $0.text = "Harris Tweed Three button Jacket"
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textAlignment = .center
    }

    private lazy var priceLabel = UILabel().then {
        $0.text = "98,000"
        $0.textColor = .orange
        $0.textAlignment = .center
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
        contentView.addSubview(cellImgeView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)

        cellImgeView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(78)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(cellImgeView.snp.bottom).inset(-4)
            $0.leading.trailing.equalToSuperview().inset(11.32)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
