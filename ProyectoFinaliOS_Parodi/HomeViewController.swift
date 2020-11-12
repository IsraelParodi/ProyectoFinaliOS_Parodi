//
//  HomeViewController.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 11/12/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit

enum ProviderType: String{
    case basic
}

class HomeViewController: UIViewController {

    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var providerPass: UILabel!
    @IBAction func btnCloseSesion(_ sender: Any) {
    }
    
    private let email: String
    private let provider: ProviderType
    
    init(email: String, provider: ProviderType){
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        user.text = email
        providerPass.text = provider.rawValue
    }
}
