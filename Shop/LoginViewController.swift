//
//  LoginViewController.swift
//  Shop
//
//  Created by wooju on 2022/12/27.
//

import UIKit
import Moya

class LoginViewController: UIViewController {
    
    private lazy var provider = MoyaProvider<Link>(plugins: [NetworkLoggerPlugin()])
    
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func createButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CreateIDViewController") as? CreateIDViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        self.loginButtonClicked()
        guard let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
        self.navigationController?.pushViewController(tabVC , animated: true)
    }
    
}
extension LoginViewController {
    private func loginButtonClicked() {
        if idTextField.text != "" && passwordTextField.text != "" {
            provider.request(Link.login(email: self.idTextField.text!, password: self.passwordTextField.text! )) { response in
        
                switch response {
                case .success(let result):
                    do {
                        let value = try JSONDecoder().decode(UserInfo.self, from: result.data)

                        print(value)
                        if result.statusCode == 200 {
                            self.setUserDataKeychainHandler(userData: value)
                            
                            print("로그인 완료! 메인탭바를 루트로 설정 후 이동")
                            print("========로그인 성공 시 받는 데이터============")
                            print(result.data)
                            
                          
                            

                        } else if result.statusCode == 400 {
                            
                        } else {
                            print(result.statusCode)
                            print("로그인오류임")
                        }
                    } catch(let err) {
                        print(result.statusCode)
                        print("/////3939393939")
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print("3[][][][][][")
                    print(err.localizedDescription)
                    
                   
                }
            }
        } else {
            print("모든 항목을 입력하세요!")
        }
    }
}
extension LoginViewController: UITextFieldDelegate {
    private func setTextFieldDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }

    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}
extension LoginViewController {
    private func setUserDataKeychainHandler(userData: UserInfo) {
        KeychainHandler.shared.accessToken = userData.token.access
        KeychainHandler.shared.nickname = userData.user.nickname
        KeychainHandler.shared.emailID = userData.user.email
    }
}
