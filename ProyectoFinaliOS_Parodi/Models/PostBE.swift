//
//  PostBE.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 11/27/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PostBE {
    var post_id: String
    var post_author: UserBE
    var post_likes: Int
    var post_postText: String
    var post_imageUrl: String
    
    var likes: Int {
        return post_likes
    }
    
    init(postId: String, postText: String, likes: Int, urlImage: String, postAuthor: UserBE) {
        self.post_id               = postId
        self.post_author           = postAuthor
        self.post_likes            = likes
        self.post_postText         = postText
        self.post_imageUrl         = urlImage
    }
    
    func adjustLikes(addlike: Bool) {
        if addlike == true {
            post_likes = likes + 1
        } else {
            post_likes = likes - 1
        }
    }
}
