//
//  CategoryMenuViewController.swift
//  Shop
//
//  Created by wooju on 2023/01/17.
//
//  CategoryMenuViewController.swift
//  example
//
//  Created by wooju on 2023/01/05.
//

import UIKit

final class CategoryMenuViewController: UIViewController {

    lazy var categoryArray = ["상의","하의","아우터","신발"]

    // 뷰 컨트롤러가 나타날 때 숨기기
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
        $0.text = "카테고리"
        $0.textColor = .darkGray
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "backward"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked), for: .touchDown)
    }

    private let collectionView:  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = true

        cv.backgroundColor = .white
        cv.register(CategoryMenuCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryMainCollectionViewCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationbarRender()
        render()
        setDelegation()
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

// MARK: - Objc
extension CategoryMenuViewController {
    @objc
    private func backButtonClicked() {
        let vc = MainHomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectionViewDelegate
extension CategoryMenuViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            let vc = CategoryListViewController()
            vc.navigationbarTitle = categoryArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectionViewDataSource
extension CategoryMenuViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return categoryArray.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryMainCollectionViewCell", for: indexPath) as? CategoryMenuCollectionViewCell else {return UICollectionViewCell()}

        cell.categoryNameLabel.text = categoryArray[indexPath.row]

        return cell
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension CategoryMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
          _ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath
     ) -> CGSize {
         return CGSize(width: 335, height: 50)
     }
}
