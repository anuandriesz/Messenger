//
//  DatabaseManager.swift
//  MessengerApp
//
//  Created by Anuradha Andriesz on 2024-03-25.
//

import Foundation
//Design a pulic function
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

extension DatabaseManager {
    public func userExist(with email: String, completion : @escaping ((Bool) -> Void) ) {
        
        database.child(email).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    /// instert new ueser to databse
    public func insertUser(with user : ChatAppUser) {
        database.child(user.emailSddress).setValue([
            "first_name": user.firstname,
            "last_name": user.lastname
        ])
    }
}

struct ChatAppUser {
    let firstname: String
    let lastname: String
    let emailSddress : String
    // let profilePic : String
}
