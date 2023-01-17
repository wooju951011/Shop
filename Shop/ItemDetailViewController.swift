//
//  ItemDetailViewController.swift
//  Shop
//
//  Created by wooju on 2023/01/17.
//
import UIKit
import Moya

final class ItemDetailViewController: UIViewController {

    private lazy var provider = MoyaProvider<Link>(plugins: [NetworkLoggerPlugin()])

    var itemID = 0
    private var itemQuantity = 1

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

    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "whiteBGLogo")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "backward"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked), for: .touchDown)
    }

    private let cartButton = UIButton().then {
        $0.setImage(UIImage(named: "shoppingBag"), for: .normal)
        $0.addTarget(self, action: #selector(cartButtonClicked), for: .touchDown)
    }

    private let itemDetailImageView = UIImageView()

    private let nameOfItem = UILabel().then {
        $0.text = "MOHAN"
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.2
        $0.numberOfLines = 1
    }

    private let descriptionOfItem = UILabel().then {
        $0.text = "Recycle Boucle Knit Cardigan Pink"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }

    private let priceLabel = UILabel().then {
        $0.text = "98,000"
        $0.textColor = .orange
    }

    private let quantityLabel = UILabel().then {
        $0.text = "수량"
        $0.textAlignment = .left
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
    }

    lazy var minusButton = UIButton().then {
        $0.setImage(UIImage(named: "minusBtn"), for: .normal)
        $0.addTarget(self, action: #selector(minusClicked), for: .touchUpInside)
    }

    lazy var numberOfitemLabel = UILabel().then {
        $0.text = String(itemQuantity)
        $0.textAlignment = .center
    }

    lazy var plusButton = UIButton().then {
        $0.setImage(UIImage(named: "plusBtn"), for: .normal)
        $0.addTarget(self, action: #selector(plusClicked), for: .touchUpInside)
    }

    

    private let putIntoCartButton = UIButton().then {
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(addToCart), for: .touchDown)
        $0.setTitle("장바구니 담기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        navigationRender()
        render()
        getItemDetailServer()
        super.viewDidLoad()
    }

    private func navigationRender() {
        view.addSubview(navigationbar)

        navigationbar.addSubview(backButton)
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

        backButton.snp.makeConstraints {
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
        view.backgroundColor = .white
        view.addSubview(itemDetailImageView)
        view.addSubview(nameOfItem)
        view.addSubview(descriptionOfItem)
        view.addSubview(priceLabel)
        view.addSubview(putIntoCartButton)
        view.addSubview(quantityLabel)
        view.addSubview(minusButton)
        view.addSubview(numberOfitemLabel)
        view.addSubview(plusButton)

        itemDetailImageView.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(510)
        }

        nameOfItem.snp.makeConstraints {
            $0.top.equalTo(itemDetailImageView.snp.bottom).inset(-18)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }

        descriptionOfItem.snp.makeConstraints {
            $0.top.equalTo(nameOfItem.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionOfItem.snp.bottom).inset(-6)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }

        quantityLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(17)
            $0.size.equalTo(30)
        }

        minusButton.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(57)
            $0.size.equalTo(24)
        }

        numberOfitemLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(81)
            $0.width.equalTo(30)
            $0.height.equalTo(24)
        }

        plusButton.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(111)
            $0.size.equalTo(24)
        }

        putIntoCartButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }

    private func getItemDetailServer() {
        provider.request(Link.getItemDetail(itemID: self.itemID)) { response in
            switch response {
            case .success(let result):
                do {
                    let value = try JSONDecoder().decode(product.self, from: result.data)
                    self.dataSetUp(itemData: value)
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    private func dataSetUp(itemData: product) {
        self.itemDetailImageView.load(url: URL(string: itemData.imageURL)!)
        self.nameOfItem.text = itemData.topName
        self.priceLabel.text = String(itemData.topPrice)
    }
}

extension ItemDetailViewController {
    @objc
    private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    func cartButtonClicked() {
        print("item detail cart button clicked")
        let vc = CartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    func addToCart() {
       // AlertviewController.showAlert(parentViewController: self, viewType: .putInToCart)
        provider.request(Link.putItemToCart(itemID: self.itemID, quantity: itemQuantity)) { response in
            switch response {
            case .success(let result):
                do {
                    print("--------------장바구니넣기성공-----------------------")
                    UIAlertAction(title: "장바구니성공", style: .default)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    @objc
    func minusClicked() {
        if numberOfitemLabel.text == "1" {
            minusButton.isEnabled = false
            print("1개 이상 구매가능합니다. 확인 팝업 띄우기")
        } else {
            itemQuantity -= 1
            numberOfitemLabel.text = String(itemQuantity)
        }
    }

    @objc
    func plusClicked() {
        minusButton.isEnabled = true
        itemQuantity += 1
        numberOfitemLabel.text = String(itemQuantity)
    }
}
