//
//  LoginViewController.swift
//  SeSAC2Week9
//
//  Created by 윤여진 on 2022/09/01.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.name.bind { text in
            self.nameTextField.text = text
        }
        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .red : .lightGray
            
        }
        
    }
    
    @IBAction func nameTextFieldClicked(_ sender: UITextField) {
        viewModel.name.value = nameTextField.text!
        viewModel.checkValidation()
    }
    @IBAction func passwordTextFieldClicked(_ sender: UITextField) {
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()

    }
    @IBAction func emailTextFiledClicked(_ sender: UITextField) {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()

    }
    
    
    @IBAction func LoginButtonClicked(_ sender: UIButton) {
        
        
    }
    
    
}
