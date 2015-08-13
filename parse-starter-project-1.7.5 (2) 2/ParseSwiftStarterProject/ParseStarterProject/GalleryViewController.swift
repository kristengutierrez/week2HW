//
//  GalleryViewController.swift
//  ParseStarterProject
//
//  Created by Kristen Kozmary on 8/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Photos


protocol ImageSelectedDelegate : class {
  func controllerDidSelectImage (UIImage) -> (Void)
}

class GalleryViewController : UIViewController {
  
      var fetchResult : PHFetchResult!
  var startingScale: CGFloat = 0
//  var scale : CGFloat = 0
  //var desiredFinalImageSize :
  let cellSize = CGSize(width: 100, height: 100)
  @IBOutlet weak var collectionView: UICollectionView!
  weak var delegate : ImageSelectedDelegate?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
    collectionView.dataSource = self
    collectionView.delegate = self
    
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchRecognized:")
    collectionView.addGestureRecognizer(pinchGesture)

    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func pinchRecognized(pinch : UIPinchGestureRecognizer) {
    if pinch.state == UIGestureRecognizerState.Began {
      println("began")
      startingScale = pinch.scale
    }
    if pinch.state == UIGestureRecognizerState.Changed {
      
    }
    if pinch.state == UIGestureRecognizerState.Ended {
//      scale = startingScale * pinch.scale
//      let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//      let newSize = CGSize(width: layout.itemSize.width * scale, height: layout.itemSize.height * scale)
//      
//      collectionView.performBatchUpdates({ () -> Void in
//      layout.itemSize = newSize
//        layout.invalidateLayout()
//      }, completion: nil)
    }
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

extension GalleryViewController : UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
 
let options = PHImageRequestOptions()
    options.synchronous = true
    
        if let asset = fetchResult[indexPath.row] as? PHAsset {
      PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: cellSize, contentMode: PHImageContentMode.AspectFill, options: options) { (image, info) -> Void in
        if let image = image {
 
          self.delegate?.controllerDidSelectImage(image)
          self.navigationController?.popViewControllerAnimated(true)
        }
      }
    }
  }
}








