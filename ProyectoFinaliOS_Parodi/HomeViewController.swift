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
import FirebaseDatabase
import SwiftKeychainWrapper

class HomeViewController: UIViewController {
    
     @IBOutlet weak var tblPlaces: UITableView!
    
    var arrayPosts = [PostBE]()
    var user = Auth.auth().currentUser
    
    var objPost: PostBE!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrayPosts.append(PostBE(postText: "Probando InstaISIL", likes: 0, urlImage: "https://arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/K3DO42WB4VGLVPBGJPL4FQXOHQ.jpg", username: (user?.email)!))
        
        self.arrayPosts.append(PostBE(postText: "Profes de software?", likes: 0, urlImage: "https://arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/K3DO42WB4VGLVPBGJPL4FQXOHQ.jpg", username: (user?.email)!))
        
        self.arrayPosts.append(PostBE(postText: "Quihuboles!", likes: 0, urlImage: "https://arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/K3DO42WB4VGLVPBGJPL4FQXOHQ.jpg", username: (user?.email)!))
        
        self.view.layer.cornerRadius = 10
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let indexSet = IndexSet(integer: 0)
        self.tblPlaces.reloadSections(indexSet, with: .fade)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               
        if let controller = segue.destination as? PostViewController {
            controller.delegate = self
        }
    }
    
    @IBAction func btnLike(_ sender: Any) {
        
    }
    
    @IBAction func btnNewPost(_ sender: Any) {
        performSegue(withIdentifier: "ToCreatePost", sender: nil)
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: "uid")
        do{
            try Auth.auth().signOut()
        } catch let signOutError as NSError{
            print("Error", signOutError)
        }
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getUserData(){
        Database.database().reference().child("users").child(KeychainWrapper.standard.string(forKey: "uid")!).observeSingleEvent(of: .value) { (snapshot) in
            
        }
    }
}

extension HomeViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PostCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostTableViewCell
        cell.objPost = self.arrayPosts[indexPath.row]
        return cell
    }
}

extension HomeViewController: PostViewControllerDelegate {
    func postViewController(_ controller: PostViewController, didRegisterPost post: PostBE) {
        self.arrayPosts.insert(post, at: 0)
    }
}

