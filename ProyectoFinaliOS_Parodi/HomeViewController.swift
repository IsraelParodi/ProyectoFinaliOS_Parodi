//
//  HomeViewController.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 11/12/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var user: UILabel!
    
    private let email: String
    
    init(email: String){
        self.email = email
        super.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        user.text = email
    }
}
