//
//  UploadProfileImageViewController.swift
//  Shop
//
//  Created by wooju on 2023/01/17.
//
import UIKit
import Moya

class UploadProfileImageViewController: UIViewController {

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

    let imagePicker = UIImagePickerController()

    private let instructionLabel = UILabel().then {
        $0.text = "자신의 사진을 올려주세요"
        $0.textColor = .gray
    }

    private lazy var profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.borderWidth = 1
        $0.backgroundColor = .lightGray
        $0.layer.masksToBounds = true
    }

    private let imageDimView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }

    private let photolibraryimageView = UIImageView().then {
        $0.image = UIImage(named: "ic_image_white_big")
    }

    private lazy var clearButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_image_white_big"), for: .normal)
        $0.addTarget(self, action: #selector(gotoPhotoLibrary), for: .touchDown)
    }
    
    override func viewDidLoad() {
        navigationbarRender()
        render()
        setPhotoDelegate()

        super.viewDidLoad()
    }

    private let navigationbar = UIView().then {
        $0.backgroundColor = .white
    }

    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "backward"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked), for: .touchDown)
    }

    private lazy var uploadButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("프로필사진 업로드", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(uploadButtonClciked), for: .touchUpInside)
    }

    private let navigationbarTitle = UILabel().then {
        $0.text = "프로필사진 업로드"
        $0.textColor = .darkGray
    }

    private func navigationbarRender() {
        view.addSubview(navigationbar)

        navigationbar.addSubview(navigationbarTitle)
        navigationbar.addSubview(backButton)

        navigationbar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }

        navigationbarTitle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }

        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }

    private func render() {
        view.backgroundColor = .white

        view.addSubview(instructionLabel)

        view.addSubview(profileImageView)
        //profileImageView.addSubview(imageDimView)
        view.addSubview(clearButton)

        view.addSubview(uploadButton)

        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(559)
        }

//        imageDimView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
        clearButton.snp.makeConstraints {
            $0.edges.equalTo(profileImageView.snp.edges)
        }

        uploadButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }

    private func setPhotoDelegate() {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
        self.imagePicker.allowsEditing = false // 수정 가능 여부
        self.imagePicker.delegate = self // picker delegate
    }
}


extension UploadProfileImageViewController {
    @objc
    private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func uploadButtonClciked() {
        print("프로필 사진 업로드")
        provider.request(Link.postProfileImage(image: (profileImageView.image!))) { response in
            switch response {
            case .success(let result):
                do {
                    if result.statusCode == 200 {
                        print("========프로필사진 업로드 성공 시 받는 데이터============")
                    } else if result.statusCode == 400 {
                        print("실패")
                    } else {
                        print(result.statusCode)
                    }
                } catch(let err) {
                    print(result.statusCode)
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }

                         }

    @objc
    private func gotoPhotoLibrary() {
        print("앨범 열기")
        self.present(self.imagePicker, animated: true)
        //photo picker
    }
}

extension UploadProfileImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        var newImage: UIImage? = nil // update 할 이미지

        if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }

        self.profileImageView.image = newImage // 받아온 이미지를 update

        picker.dismiss(animated: true) {
            self.photolibraryimageView.isHidden = true
        } // picker를 닫아줌
    }
}

