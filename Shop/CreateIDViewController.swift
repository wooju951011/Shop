//
//  CreateIDViewController.swift
//  Shop
//
//  Created by wooju on 2023/01/02.
//

import UIKit
import Moya
import Then

class CreateIDViewController: ViewController {
    
    private lazy var provider = MoyaProvider<Link>(plugins: [NetworkLoggerPlugin()])
    
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nicknameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    @IBAction func completeButton(_ sender: UIButton) {
        self.completeButtonClicked()
        self.navigationController?.popViewController(animated: true)  
    }
    private let wrongPasswordMessage = UILabel().then {
        $0.text = "비밀번호가 일치하지않습니다"
        $0.textColor = .red
        $0.isHidden = true
    }
}
extension CreateIDViewController {
    @objc
    private func completeButtonClicked() {
        if idField.text != "" && passwordField.text != "" &&
            nicknameField.text != "" && wrongPasswordMessage.isHidden {

            provider.request(Link.signUp(
                email: self.idField.text! ,
                password: self.passwordField.text! ,
                nickname: self.nicknameField.text! )) { response in
                switch response {
                case .success(let result):
                    do {
                        //print(result)
                        print("-------------------------------------")
                        print(result.statusCode)
                        print("회원가입 원료!!")
                        
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        } else {
            print("모든 항목을 입력하세요!")
        }
    }
}
extension CreateIDViewController: UITextFieldDelegate {
    private func textFieldDelegate() {
        idField.delegate = self
        passwordField.delegate = self
        nicknameField.delegate = self
    }
}


    

