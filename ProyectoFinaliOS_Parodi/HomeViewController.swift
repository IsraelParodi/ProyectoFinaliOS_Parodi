//
//  HomeViewController.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 11/27/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSignOut(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: "uid")
        do{
            try Auth.auth().signOut()
        } catch let signOutError as NSError{
            print("Error", signOutError)
        }
    }
}
