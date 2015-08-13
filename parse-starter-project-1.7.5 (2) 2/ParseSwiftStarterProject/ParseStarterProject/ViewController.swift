//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
  
      let kCollectionViewHeightOffScreen : CGFloat = -150
    let kThumbnailSize = CGSize(width: 100, height: 100)
  
  @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var alertButton: UIButton!
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  let picker: UIImagePickerController = UIImagePickerController()
  
  let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
  
  var filters : [(UIImage, CIContext) -> (UIImage!)] = [FilterService.sepiaImageFromOriginalImage, FilterService.chromeImageFromOriginalImage, FilterService.transferImageFromOriginalImage, FilterService.fadeImageFromOriginalImage, FilterService.sharpenImageFromOriginalImage]
  let context = CIContext(options: nil)
  
  var thumbnail : UIImage!
  
  
  var displayImage : UIImage! {
    didSet {
      imageView.image = displayImage
      thumbnail = ImageResizer.resizeImage(displayImage, size:kThumbnailSize)
      collectionView.reloadData()
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      imageView.image = UIImage(named: "photo.jpg")
       collectionView.dataSource = self
      collectionView.delegate = self
      
      let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alert) -> Void in
        println("Alert cancelled")
      }
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (alert) -> Void in
          self.presentViewController(self.picker, animated: true, completion: nil)
        }
              alert.addAction(cameraAction)
      }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default) { (alert) -> Void in
          self.presentViewController(self.picker, animated: true, completion: nil)
        }
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
let collectionViewAction = UIAlertAction(title: "Collection View", style: UIAlertActionStyle.Default) { (alert) -> Void in
  self.enterFilterMode()
      }
        alert.addAction(collectionViewAction)
      }
      
      let uploadAction = UIAlertAction(title: "Upload", style: UIAlertActionStyle.Default) { (alert) -> Void in
        let post = PFObject(className: "Post")
        post["text"] = "blah blah"
        if let image = self.imageView.image,
                data = UIImageJPEGRepresentation(image, 1.0)
        {
          let file = PFFile(name: "post.jpeg", data: data)
          post["image"] = file
        }
        post.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
          
        })
        
      }
      
      let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) { (alert) -> Void in
        self.performSegueWithIdentifier("gallerySegue", sender: self)
      }
      alert.addAction(photoLibraryAction)
      alert.addAction(galleryAction)
      alert.addAction(uploadAction)
      alert.addAction(cancelAction)
    

      self.picker.delegate = self
      self.picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
      
     self.thumbnail = ImageResizer.resizeImage(imageView.image!, size: CGSize(width: 200, height: 200))
      collectionView.reloadData()
      
      
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func buttonPressed(sender: AnyObject) {
      alert.modalPresentationStyle = UIModalPresentationStyle.Popover
      if let popover = alert.popoverPresentationController {
        
        popover.sourceView = view
        popover.sourceRect = alertButton.frame
      }
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "gallerySegue" {
      if let galleryViewController = segue.destinationViewController as? GalleryViewController {

      }
    }
  }
  
  
  func enterFilterMode(){
    collectionViewBottomConstraint.constant = 0
    
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "closeCollectionViewMode")
    navigationItem.rightBarButtonItem = doneButton
  }
  func closeCollectionViewMode() {
      collectionViewBottomConstraint.constant = kCollectionViewHeightOffScreen
      
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        self.view.layoutIfNeeded()
      })
    }
  
  }


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    let image: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    self.imageView.image = image
    self.picker.dismissViewControllerAnimated(true, completion: nil)
  }
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.picker.dismissViewControllerAnimated(true, completion: nil)
    println("Picker Cancelled")
    
  }}

//MARK: UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filters.count
  }
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ThumbnailCell", forIndexPath: indexPath) as! ThumbnailCell
    let filter = filters[indexPath.row]
    
    if let thumbnail = thumbnail {
      let filteredImage = filter(thumbnail, context)
      cell.cellImageView.image = filteredImage
      var arr = ["Sepia","Chrome","Transfer","Fade","Sharpen"]
        cell.label.text = arr[indexPath.row]

    } else {
      println("thumbnail failed")
    }
    return cell
  }
}

//MARK: UICollectionViewDelegate
extension ViewController : UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ThumbnailCell", forIndexPath: indexPath) as! ThumbnailCell
    cell.cellImageView.image = displayImage
  }
}


//MARK: ImageSelectedDelegate
extension ViewController : ImageSelectedDelegate {
  func controllerDidSelectImage(newImage: UIImage) {
    displayImage = newImage
  }
}


