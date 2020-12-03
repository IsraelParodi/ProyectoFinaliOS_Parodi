//
//  UserService.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 3/12/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UserService{
    
    static var currentUserProfile: UserBE?
    
    static func observeUserProfile(_ uid: String, completion: @escaping ((_ userBE: UserBE?)->())){
        let userRef = Database.database().reference().child("user/profile/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userBE: UserBE?
            
            if  let dict = snapshot.value as? [String:Any],
                let email = dict["email"] as? String{
                
                userBE = UserBE(uid: snapshot.key, email: email)
                
            }
            
            completion(userBE)
            
        })
    }
    
}
