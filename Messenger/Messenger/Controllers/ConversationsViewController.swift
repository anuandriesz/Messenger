//
//  ViewController.swift
//  Messenger
//
//  Created by Anuradha Andriesz on 2024-03-19.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //DatabaseManager.shared.test()
    }
    
    //check if the user is signed in
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        validateAuth()
        
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc =  LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated:false)
        }
    }
}

