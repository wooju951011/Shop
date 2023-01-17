//
//  CartViewController.swift
import UIKit
import Moya
import RxSwift

final class CartViewController: UIViewController {

    private var cartData = Cart(data: [], totalBill: 0)

    private lazy var provider = MoyaProvider<Link>(plugins: [NetworkLoggerPlugin()])

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true// 뷰 컨트롤러가 나타날 때 숨기기
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: true) // 뷰 컨트롤러가 사라질 때 나타내기
        tabBarController?.tabBar.isHidden = false
    }

    private let collectionView:  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = true

        cv.backgroundColor = .clear
        cv.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: "CartCollectionViewCell")
        cv.register(CartViewFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CartViewFooterCollectionReusableView")
        cv.contentInset = UIEdgeInsets(top: 5, left: 13, bottom: 15, right: 13)
        return cv
    }()

    private let navigationbar = UIView().then {
        $0.backgroundColor = .white
    }


    private let titleLabel = UILabel().then {
        $0.text = "장바구니"
        $0.textColor = .darkGray
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "backward"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked), for: .touchDown)
    }

    private let divideLine = UIView().then {
        $0.backgroundColor = .gray
    }

    private let totalPriceTitleLabel = UILabel().then {
        $0.text = "총 상품금액"
        $0.textColor = .red
    }

    private let totalPriceLabel = UILabel().then {
        $0.text = "59,000"
        $0.textColor = .white
    }

    private let buyButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("구매하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        setDelegate()
        navigationbarRender()
        render()
        showCartList()

//        vc.delegate = self

        super.viewDidLoad()
    }

    private func navigationbarRender() {
        view.addSubview(navigationbar)

        navigationbar.addSubview(backButton)
        navigationbar.addSubview(titleLabel)

        navigationbar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }

        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    private func render() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(buyButton)

        buyButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom).inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(buyButton.snp.top).inset(-10)
        }
    }

    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - CollectionViewDataSource
extension CartViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return cartData.data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionViewCell", for: indexPath) as? CartCollectionViewCell else {return UICollectionViewCell()}

        cell.delegate = self

        cell.setupCart(cartData.data[indexPath.row])

        return cell
    }
}

extension CartViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            print(indexPath.row)

    }
}

//  MARK: - CollectionViewDelegateFlowLayout
extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 343, height: 134)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath)
    -> UICollectionReusableView {

        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartViewFooterCollectionReusableView", for: indexPath) as! CartViewFooterCollectionReusableView
        
        footerView.setupCartFooter(cartData)

        return footerView
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

}

extension CartViewController {
    func showCartList() {
        provider.request(Link.getCartList) { response in
            switch response {
            case .success(let result):
                do {
                    //print(result)
                    //print("-------------------------------------")
                    let value = try JSONDecoder().decode(Cart.self, from: result.data)

                    self.cartData = value
                    print(value)
                    self.collectionView.reloadData()
                   
                } catch(let err) {
                    print("1111111")
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print("2222222")
                print(err.localizedDescription)
            }
        }
    }
}

extension CartViewController {
    @objc
    private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension CartViewController: DeleteCartItemDelegation {
    func deleteItem(cell: UICollectionViewCell) {
        UIAlertAction(title: "삭제되었습니다.", style: .default)
    }
}
