//
//  MyProfileViewController.swift
//  Shop
//
//  Created by wooju on 2023/01/17.
//

import UIKit

final class MyProfileViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true// 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: true) // 뷰 컨트롤러가 사라질 때 나타내기
    }

    private let navigationbar = UIView().then {
        $0.backgroundColor = .white
    }

    private let navigationbarTitle = UILabel().then {
        $0.text = "마이페이지"
        $0.textColor = .darkGray
    }

    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profileImage")
        $0.layer.cornerRadius = $0.frame.width/2
        $0.layer.borderWidth = 1.0

        $0.clipsToBounds = true
    }

    private let nameLabel = UILabel().then {
        $0.text = KeychainHandler.shared.nickname
        $0.font = .boldSystemFont(ofSize: 20)
    }

    private let emailLabel = UILabel().then {
        $0.text = KeychainHandler.shared.emailID
        $0.textColor = .lightGray
    }

    private lazy var modifyProfileButton = UIButton().then {
        $0.setTitle("프로필 수정", for: .normal)
        $0.backgroundColor = .red
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(uploadProfile), for: .touchUpInside)
    }

    private let divideLine = UIView().then {
        $0.backgroundColor = .blue
    }

    private let uploadLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "업로드"
        $0.font = .systemFont(ofSize: 14)
    }

    private let gotoProfileUpload = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("프로필사진 업로드", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.titleLabel?.font = .boldSystemFont(ofSize: 19)

        $0.configuration?.image = UIImage(named: "Forward")
        $0.configuration?.imagePlacement = .trailing

        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        $0.addTarget(self, action: #selector(uploadProfileImage), for: .touchUpInside)
    }

    private let forwordButton = UIButton().then {
        $0.setImage(UIImage(named: "Forward"), for: .normal)
        $0.addTarget(self, action: #selector(uploadProfileImage), for: .touchUpInside)
    }

    private let gotoBackgroundUpload = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("피팅사진 업로드", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.titleLabel?.font = .boldSystemFont(ofSize: 19)

        $0.configuration?.image = UIImage(named: "Forward")
        $0.configuration?.imagePlacement = .trailing

        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        $0.addTarget(self, action: #selector(uploadBackgroundImage), for: .touchUpInside)
    }

    private let forwordButton2 = UIButton().then {
        $0.setImage(UIImage(named: "Forward"), for: .normal)
        $0.addTarget(self, action: #selector(uploadBackgroundImage), for: .touchUpInside)
    }

    private let serviceLabel = UILabel().then {
        $0.textColor = .systemGray
        $0.text = "서비스"
        $0.font = .systemFont(ofSize: 14)
    }

    private let logoutButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 19)
        $0.contentHorizontalAlignment = .left
//        $0.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)®
    }

    override func viewDidLoad() {
        navigationbarRender()
        render()

        super.viewDidLoad()
    }

    private func navigationbarRender() {
        view.addSubview(navigationbar)

        navigationbar.addSubview(navigationbarTitle)

        navigationbar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }

        navigationbarTitle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    private func render() {
        view.backgroundColor = .white

        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(modifyProfileButton)

        view.addSubview(divideLine)

        view.addSubview(uploadLabel)
        view.addSubview(gotoProfileUpload)
        view.addSubview(forwordButton)

        view.addSubview(gotoBackgroundUpload)
        view.addSubview(forwordButton2)

        view.addSubview(serviceLabel)
        view.addSubview(logoutButton)

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom).inset(-28)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(60)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom).inset(-28)
            $0.leading.equalToSuperview().inset(88)
            $0.width.equalToSuperview().inset(10)
            $0.height.equalTo(32)
        }

        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-9)
            $0.leading.equalToSuperview().inset(88)
            $0.width.equalToSuperview().inset(10)
            $0.height.equalTo(15)
        }

        modifyProfileButton.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom).inset(-29)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(82)
            $0.height.equalTo(32)
        }

        divideLine.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        uploadLabel.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }

        gotoProfileUpload.snp.makeConstraints {
            $0.top.equalTo(uploadLabel.snp.bottom).inset(-17)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(310)
            $0.height.equalTo(54)
        }

        forwordButton.snp.makeConstraints {
            $0.top.equalTo(uploadLabel.snp.bottom).inset(-17)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(54)
        }

        gotoBackgroundUpload.snp.makeConstraints {
            $0.top.equalTo(gotoProfileUpload.snp.bottom).inset(-14)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(310)
            $0.height.equalTo(54)
        }

        forwordButton2.snp.makeConstraints {
            $0.top.equalTo(gotoProfileUpload.snp.bottom).inset(-14)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(54)
        }

        serviceLabel.snp.makeConstraints {
            $0.top.equalTo(gotoBackgroundUpload.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(15)
            $0.width.equalTo(60)
            $0.height.equalTo(20)
        }

        logoutButton.snp.makeConstraints {
            $0.top.equalTo(serviceLabel.snp.bottom).inset(-17)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
    }
    
}

extension MyProfileViewController {
    @objc
    private func uploadProfileImage() {
        let uploadVC = UploadProfileImageViewController()
        self.navigationController?.pushViewController(uploadVC, animated: true)
    }


    @objc
    private func uploadProfile() {
        let uploadVC = UploadProfileImageViewController()
        self.navigationController?.pushViewController(uploadVC, animated: true)
    }

    @objc
    private func uploadBackgroundImage() {
        let vc = BackgroundViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


