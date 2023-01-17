//
//  MainHomeViewController.swift
//  example
//
//  Created by wooju on 2023/01/05.
//


import UIKit
import SnapKit
import Then

protocol tempProtocol: AnyObject{
    func tempFunc()
}
final class MainHomeViewController: UIViewController {

    weak var delegate: tempProtocol?

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true// 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: true) // 뷰 컨트롤러가 사라질 때 나타내기
    }

    override func viewDidLoad() {
        setDelegate()
        navigationRender()
        render()
        scrollViewRender()
        super.viewDidLoad()
    }

    private let navigationbar = UIView().then {
        $0.backgroundColor = .gray
    }

    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "grayBGLogo")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let categoryButton = UIButton().then {
        $0.setImage(UIImage(named: "btnHomeCategory"), for: .normal)
        $0.addTarget(self, action: #selector(categoryButtonClicked), for: .touchDown)
    }
   
    private let cartButton = UIButton().then {
        $0.setImage(UIImage(named: "shoppingBag"), for: .normal)
        $0.addTarget(self, action: #selector(cartButtonClicked), for: .touchDown)
    }


    private let mainImageView = UIImageView().then {
        $0.image = UIImage(named: "Banner")
    }

    private let scrollView = UIScrollView().then {
            $0.alwaysBounceVertical = false
    }

    private let contentView = UIView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

//    private let cvHeaderView = HeaderView()

    private let collectionView:  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = true

        cv.backgroundColor = .clear
        cv.register(MainHomeCollectionViewCell.self, forCellWithReuseIdentifier: "MainHomeCollectionViewCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return cv
    }()

    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func navigationRender() {
        view.addSubview(navigationbar)

        navigationbar.addSubview(categoryButton)
        navigationbar.addSubview(cartButton)
        navigationbar.addSubview(logoImageView)

        navigationbar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }

        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(130)
        }

        categoryButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        cartButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }

    private func render() {
        self.view.backgroundColor = .white
        
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(scrollView)
            $0.width.equalTo(scrollView)
        }
    }

    private func scrollViewRender() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(collectionView)
//        contentView.addSubview(cvHeaderView)

        mainImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(600)
        }
    }
}



// MARK: - @objc
extension MainHomeViewController {
    @objc
    func categoryButtonClicked(){
        let vc = CategoryMenuViewController()
        self.delegate?.tempFunc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func cartButtonClicked() {
        let vc = CartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
    
    // MARK: - CollectionViewDelegate
    extension MainHomeViewController: UICollectionViewDelegate {
        func collectionView(
            _ collectionView: UICollectionView,
            didSelectItemAt indexPath: IndexPath) {
                let vc = ItemDetailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    // MARK: - CollectionViewDataSource
    extension MainHomeViewController: UICollectionViewDataSource {
        func collectionView(
            _ collectionView: UICollectionView,
            numberOfItemsInSection section: Int
        ) -> Int {
            return 3
        }
        
        func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainHomeCollectionViewCell", for: indexPath) as? MainHomeCollectionViewCell else {return UICollectionViewCell()}
            
            return cell
        }
    }

    // MARK: - CollectionViewDelegateFlowLayout
    extension MainHomeViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
            return CGSize(width: 255, height: 390)
        }
    }
    

