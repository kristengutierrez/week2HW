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
                image = UIImage(data: data)
              //NSOperationQueue.mainQueue()
              {
//                  let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
//                  self.view.addSubview(imageView)
//                  imageView.image = image
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
