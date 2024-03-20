//
//  RegisterViewController.swift
//  MessengerApp
//
//  Created by Anuradha Andriesz on 2024-03-19.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName:"person")
        imageview.tintColor = .gray
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let firstName : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name here "
        
        field.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let lastName : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last name here "
        
        field.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
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
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Register", for:.normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //add subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstName)
        scrollView.addSubview(lastName)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture =  UITapGestureRecognizer(target: self,
                                              action:#selector (didTapChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
        
    }
    
    @objc private func didTapChangeProfilePic() {
        print("change picture ----")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        
        imageView.frame = CGRect(x:(view.width - size)/2 ,
                                 y: 20,
                                 width: size,
                                 height:size)
        firstName.frame = CGRect(x:30 ,
                                 y: imageView.bottom + 10,
                                 width: scrollView.width - 60,
                                 height:52)
        lastName.frame = CGRect(x:30 ,
                                y: firstName.bottom + 10,
                                width: scrollView.width - 60,
                                height:52)
        
        emailField.frame = CGRect(x:30 ,
                                  y: lastName.bottom + 10,
                                  width: scrollView.width - 60,
                                  height:52)
        passwordField.frame = CGRect(x:30 ,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height:52)
        
        registerButton.frame = CGRect(x:30 ,
                                      y: passwordField.bottom + 20,
                                      width: scrollView.width - 60,
                                      height:52)
    }
    
    @objc private func  registerButtonTap() {
        guard let firstName = firstName.text , let lastName = lastName.text, let email = emailField.text, let password = passwordField.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            return
        }
        
        //Register
        
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message:"Please enter all informations to create a new account",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerButtonTap()
        }
        return true
    }
}
