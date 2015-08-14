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
  var arr = [UIImage]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let query = PFQuery(className: "Post")
    query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
      if let error = error {
        println(error.localizedDescription)
      } else if let posts = results as? [PFObject] {
        println(posts.count)
        for post in posts {
          if let imageFile = post["image"] as? PFFile {
            imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
              if let error = error {
                println(error.localizedDescription)
              } else if let data = data,
                image = UIImage(data: data){
                  NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                   self.arr.append(image)
                  })
              }
            })
          }
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

//MARK: UITableViewDataSource
extension TimelineViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
    //return self.posts.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PostCell
//var image = cell.timelineImageView.image
   var selectedCell =  arr[indexPath.row]
    cell.timelineImageView.image = selectedCell
return cell

}

}

