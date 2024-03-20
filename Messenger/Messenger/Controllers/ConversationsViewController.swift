//
//  ViewController.swift
//  Messenger
//
//  Created by Anuradha Andriesz on 2024-03-19.
//

import UIKit

class ConversationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    //check if the user is signed in
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //userDefaults use to save some data
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn{
            let vc =  LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated:false)
        }
    }
}

