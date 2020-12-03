//
//  CommentBE.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 3/12/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CommentBE {
    
    var comment_id: String
    var comment_author: UserBE
    var comment_Text: String
    
    init(commentId: String, commentText: String, commentAuthor: UserBE) {
        self.comment_id               = commentId
        self.comment_author           = commentAuthor
        self.comment_Text             = commentText
    }
    
}
