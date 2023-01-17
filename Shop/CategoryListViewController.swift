//
//  CategoryListViewController.swift
//  Shop
//
//  Created by wooju on 2023/01/17.
//

import UIKit
import SnapKit
import Moya

class CategoryListViewController: UIViewController {

    public lazy var navigationbarTitle = "상의"
    private var topData: [product] = []
    private var itemPk = 0

    private lazy var provider = MoyaProvider<Link>(plugins: [NetworkLoggerPlugin()])

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    // 뷰 컨트롤러가 사라질 때 나타내기
    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = false
    }

    private let navigationbar = UIView().then {
        $0.backgroundColor = .white
    }

    private let titleLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .darkGray
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "backward"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked), for: .touchDown)
    }

    private let collectionView:  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 15

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = true

        cv.backgroundColor = .white
        cv.register(CategoryListCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryDetailCollectionViewCell")
        cv.contentInset = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        return cv
    }()

    override func viewDidLoad() {
        setDelegation()
        navigationbarRender()
        render()
        print(navigationbarTitle)

        showTopList()


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
        titleLabel.text = navigationbarTitle
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setDelegation() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CategoryListViewController {
    @objc
    private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CollectionViewDelegate
//extension CategoryListViewController: UICollectionViewDelegate {
//    func collectionView(
//        _ collectionView: UICollectionView,
//        didSelectItemAt indexPath: IndexPath) {
//            let vc = ItemDetailViewController()
//            vc.itemID = topData[indexPath.row].topPrimaryNumber
//
//            navigationController?.pushViewController(vc, animated: true)
//    }
//}

// MARK: - CollectionViewDataSource
extension CategoryListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return topData.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCollectionViewCell", for: indexPath) as? CategoryListCollectionViewCell else {return UICollectionViewCell()}

        cell.setup(_: topData[indexPath.row])

        return cell
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension CategoryListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
          _ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath
     ) -> CGSize {
         return CGSize(width: 165, height: 285)
     }
}

extension CategoryListViewController {
    // MARK: - Network : fetchLookDetail
    func showTopList() {
        provider.request(Link.getItemList) { response in
            switch response {
            case .success(let result):
                do {
                    let value = try JSONDecoder().decode([product].self, from: result.data)
                    self.topData = value
           
                    self.collectionView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
