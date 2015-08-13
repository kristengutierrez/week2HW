//
//  GalleryViewController.swift
//  ParseStarterProject
//
//  Created by Kristen Kozmary on 8/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Photos

class GalleryViewController : UIViewController {
  
      var fetchResult : PHFetchResult!
  

  let cellSize = CGSize(width: 100, height: 100)
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    let result = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
    

    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}


extension GalleryViewController : UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return fetchResult.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! GridCell
    
    
    if let asset = fetchResult[indexPath.row] as? PHAsset {
     PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: cellSize, contentMode: PHImageContentMode.AspectFill, options: nil) { (image, info) -> Void in
        if let image = image {
          cell.gridImageView.image = image
        }
      }
    }
    return cell
  }

}