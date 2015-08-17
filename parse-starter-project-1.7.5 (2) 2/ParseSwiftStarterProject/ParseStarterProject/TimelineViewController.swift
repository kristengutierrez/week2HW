//
//  TimelineViewController.swift
//  ParseStarterProject
//
//  Created by Kristen Kozmary on 8/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var images = [UIImage?]()
  var otherImages: [UIImage?] = [nil]
  var allPosts = [PFObject]()
  
  //andrewcbancroft tutorial basics of pull to refresh for swift developers
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    return refreshControl
    }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.addSubview(self.refreshControl)
    
    tableView.dataSource = self
    
    let query = PFQuery(className: "Post")
    query.orderByDescending("createdAt")
    query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
      if let error = error {
        println(error.localizedDescription)
      } else if let posts = results as? [PFObject] {
        println(posts.count)
        self.allPosts = posts
        
        for post in posts{
          self.images.append(nil)
        }
        
        self.tableView.reloadData()
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  func handleRefresh(refreshControl: UIRefreshControl) {


    self.tableView.reloadData()
    refreshControl.endRefreshing()
  }
}

//MARK: UITableViewDataSource
extension TimelineViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allPosts.count

  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PostCell
    
    cell.tag++
    let tag = cell.tag
    cell.timelineImageView.image = nil
    
    if cell.tag == tag {
      let currentPost = allPosts[indexPath.row]
      
      if let currentImage = images[indexPath.row]{
        cell.timelineImageView.image = currentImage
      } else if let imageFile = currentPost["image"] as? PFFile {
        imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
          if let error = error {
            println(error.localizedDescription)
          } else if let data = data,
            image = UIImage(data: data){
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.images.insert(image, atIndex: indexPath.row)
                cell.timelineImageView.image = image
                self.tableView.reloadData()
              })
          }
        })
      }
    }
//   var selectedCell =  images[indexPath.row]
//    cell.timelineImageView.image = selectedCell
return cell

}

}

