//
//  PostListViewController.swift
//  Post
//
//  Created by Austin Goetz on 12/3/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var postListTableView: UITableView!
    
    let postController = PostController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postListTableView.delegate = self
        postListTableView.dataSource = self
        
        postController.fetchPosts {
            DispatchQueue.main.async {
                self.postListTableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Data Source/Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postController.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        let post = postController.posts[indexPath.row]
        
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(post.username) - \(Date(timeIntervalSince1970: post.timestamp))"
        
        return cell
    }
}
