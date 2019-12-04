//
//  PostController.swift
//  Post
//
//  Created by Austin Goetz on 12/3/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation

class PostController {
    
    let baseURL = URL(string: "http://devmtn-posts.firebaseio.com/posts")
    
    // MARK: - SoT
    var posts: [Post] = []
    
    func fetchPosts(reset: Bool = true, completion: @escaping() -> Void) {
        
        guard let unwrappedURL = baseURL else { completion(); return }
        
        let getterEndpoint = unwrappedURL.appendingPathComponent("json")
        
        var request = URLRequest(url: getterEndpoint)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion()
                return
            }
            
            guard let data = data else { completion(); return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let postsDictionary = try jsonDecoder.decode([String:Post].self, from: data)
                let posts: [Post] = postsDictionary.compactMap({ $0.value })
                let sortedPosts = posts.sorted(by: { $0.timestamp > $1.timestamp })
                if reset {
                    self.posts = sortedPosts
                } else {
                    self.posts.append(contentsOf: sortedPosts)
                }
                completion()
            } catch {
                print(error)
                completion()
                return
            }
        }
        dataTask.resume()
    }
}
