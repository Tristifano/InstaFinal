//
//  PostService.swift
//  InstaFinal
//
//  Created by MacBook on 2/26/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import Firebase

class PostService {
    static var currentPost:Post?
    
    static func observePost(_ uid:String, completion: @escaping ((_ post:Post?)->())) {
        let postsRef = Database.database().reference().child("posts")
        
        postsRef.observe(.value, with: { snapshot in
            var post:Post?
            
            
            if let dict = snapshot.value as? [String:Any],
                let uid = dict["\(uid)"] as? String,
                let photoURL = dict["photoURL"] as? String,
                let url = URL(string:photoURL) {
                
                post = Post(id: snapshot.key, uid: post!.uid , caption: post!.caption, photoURL: url)
            }
            
            completion(post)
        })
    }
    
    
}
