//
//  Post.swift
//  InstaFinal
//
//  Created by MacBook on 2/26/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation

class Post {
    var id: String
    var uid: String
    var caption: String
    var photoURL: URL
    
    init(id: String, uid: String, caption: String, photoURL: URL) {
        self.id = id
        self.uid = uid
        self.caption = caption
        self.photoURL = photoURL
    }
}
