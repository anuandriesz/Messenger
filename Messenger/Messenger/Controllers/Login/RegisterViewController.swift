//
//  RegisterViewController.swift
//  MessengerApp
//
//  Created by Anuradha Andriesz on 2024-03-19.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName:"person.circle")
        imageview.tintColor = .gray
        imageview.contentMode = .scaleAspectFit
        imageview.layer.masksToBounds = true
        imageview.layer.borderWidth = 2
        imageview.layer.borderColor = UIColor.lightGray.cgColor
        return imageview
    }()
    
    private let firstNameField : UITextField = {
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
    
    private let lastNameField : UITextField = {
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
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        imageView.isUserInteractionEnabled = true
        
        
        scrollView.isUserInteractionEnabled = true
        
        registerButton.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
        
        let gesture =  UITapGestureRecognizer(target: self,
                                              action:#selector(didTapChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
        
    }
    
    @objc private func didTapChangeProfilePic() {
        
        presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        
        imageView.frame = CGRect(x:(view.width - size)/2 ,
                                 y: 20,
                                 width: size,
                                 height:size)
        imageView.layer.cornerRadius = imageView.width/2.0
        firstNameField.frame = CGRect(x:30 ,
                                      y: imageView.bottom + 10,
                                      width: scrollView.width - 60,
                                      height:52)
        lastNameField.frame = CGRect(x:30 ,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height:52)
        
        emailField.frame = CGRect(x:30 ,
                                  y: lastNameField.bottom + 10,
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
        guard let firstName = firstNameField.text , let lastName = lastNameField.text, let email = emailField.text, let password = passwordField.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError(message: "Please enter all fields to complete registration")
            return
        }
        
        //Register
        
        DatabaseManager.shared.userExist(with: email, completion: {[weak self]exist in
            guard let strongSelf = self else {
                return
            }
            
            guard !exist else {
                strongSelf.alertUserLoginError(message: "User already registerd, Please enter a diffrent email address.")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self ]authResult, error in
                
                guard let strongSelf = self else {
                    return
                }
                guard let result = authResult, error == nil else {
                    print("Error creating user.")
                    return
                }
                
                DatabaseManager.shared.insertUser(with:  ChatAppUser(firstname: "Ayesha", lastname: "Az", emailSddress: "ayesha@mail.com"))
                
                //            let user = result.user
                //            print("crete user :\(user)")
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                
            })
        })
        
        
    }
    
    func alertUserLoginError(message: String) {
        let alert = UIAlertController(title: "Woops",
                                      message:message,
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

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title:"Profile Picture", message:"How would you like to selcet a picture", preferredStyle:.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler:{[weak self] _ in
            self?.presentCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Chose Photo", style: .default, handler: {[weak self ] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated:true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard  let  selctedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else   {
            return
        }
        self.imageView.image = selctedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
