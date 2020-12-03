//
//  PostTableViewCell.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 11/27/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

protocol PostTableViewCellDelegate {
    func postTableViewCell(_ cell: PostTableViewCell, deletePlace post: PostBE)
}

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tblPlaces: UITableView!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imgUrl: UIImageView!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var buttonShare: UIButton!
    
    @IBAction func btnLike(_ sender: Any) {
        if buttonLike.isTouchInside{
            self.objPost.adjustLikes(addlike: true)
        }
    }
    
    var delegate: PostTableViewCellDelegate?
    var userPostKey: DatabaseReference!
    let currentUser = KeychainWrapper.standard.string(forKey: "uid")

    public var objPost: PostBE! {
        didSet {
            self.updateData()
        }
    }
    private func updateData() {
        
        self.username.text       = self.objPost.post_author.email
        self.postText.text    = self.objPost.post_postText
        self.likes.text = String(self.objPost.post_likes)
        
        self.imgUrl.downloadImageInUrlString(self.objPost.post_imageUrl) { (image, urlImage) in
            
            if self.objPost.post_imageUrl == urlImage {
                self.imgUrl.image = image
            }
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        
        self.viewContainer.layer.cornerRadius = 5
        self.buttonLike.clipsToBounds = true
        self.buttonLike.layer.cornerRadius = 20
        self.buttonLike.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        self.buttonShare.clipsToBounds = true
        self.buttonShare.layer.cornerRadius = 20
        self.buttonShare.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }

}
