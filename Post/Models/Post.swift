//
//  Post.swift
//  Post
//
//  Created by Austin Goetz on 12/3/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation

class Post: Decodable {
    let text: String
    let timestamp: TimeInterval
    let username: String
    
    init(text: String, timestamp: TimeInterval = Date().timeIntervalSince1970, username: String) {
        self.text = text
        self.timestamp = timestamp
        self.username = username
    }
}
