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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 10
        
        observePosts()
    
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
    
    func observePosts(){
        let postRef = Database.database().reference().child("posts")
        postRef.observe(.value, with: { snapshot in
            
            var tempPosts = [PostBE]()
            
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String: Any],
                    let author = dict["author"] as? [String: Any],
                    let uid = author["uid"] as? String,
                    let email = author["email"] as? String,
                    let text = dict["text"] as? String,
                    let urlImage = dict["urlImage"] as? String{
                    
                    let userProfile = UserBE(uid: uid, email: email)
                    let post = PostBE(postId: childSnapshot.key, postText: text, likes: 0, urlImage: urlImage, postAuthor: userProfile)
                    
                    tempPosts.append(post)
                    
                }
            }
            
            self.arrayPosts = tempPosts
            self.tblPlaces.reloadData()
            
        })
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

