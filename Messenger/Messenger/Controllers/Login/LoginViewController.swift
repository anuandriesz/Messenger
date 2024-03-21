//
//  LoginViewController.swift
//  MessengerApp
//
//  Created by Anuradha Andriesz on 2024-03-19.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "ellipses.bubble")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let emailField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email here "
        
        field.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password here "
        
        field.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for:.normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style:.done, target: self, action:#selector(didTapRegister))
        
        //Adding a target to the button
        loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        
        imageView.frame = CGRect(x:(view.width - size)/2 ,
                                 y: 20,
                                 width: size,
                                 height:size)
        
        emailField.frame = CGRect(x:30 ,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height:52)
        passwordField.frame = CGRect(x:30 ,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height:52)
        
        loginButton.frame = CGRect(x:30 ,
                                   y: passwordField.bottom + 20,
                                   width: scrollView.width - 60,
                                   height:52)
    }
    
    @objc private func loginButtonTap() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        //Firebase Login
        FirebaseAuth.Auth.auth().signIn(withEmail: "joe@gmail.com", password: "Joe12345", completion: {authResult, error in
            guard let result = authResult, error == nil else {
                print("Faield to Login user")
                return
            }
            
            let user = authResult?.user
            print("Logged In user \(user)")
        })
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message:"Please enter all informations to Log In",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            loginButtonTap()
        }
        return true
    }
}
