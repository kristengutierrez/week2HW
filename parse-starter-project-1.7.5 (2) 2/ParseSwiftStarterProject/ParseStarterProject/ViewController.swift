//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
  
  
  @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var alertButton: UIButton!
  
  let picker: UIImagePickerController = UIImagePickerController()
  let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
//      if let constraints = view.constraints() as? [NSLayoutConstraint] {
//        println(constraints.count)
//      }
      
      
      
      
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

      
      
      let chromeAction = UIAlertAction(title: "Chrome", style: UIAlertActionStyle.Default) { (alert) -> Void in
        let image = CIImage(image: self.imageView.image)
        let chromeFilter = CIFilter(name: "CIPhotoEffectChrome")
        chromeFilter.setValue(image, forKey: kCIInputImageKey)
        
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
        
        let outputImage = chromeFilter.outputImage
        let extent = outputImage.extent()
        
        let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
        let finalImage = UIImage(CGImage: cgImage)
        self.imageView.image = finalImage
      }
      let sepiaAction = UIAlertAction(title: "Sepia", style: UIAlertActionStyle.Default) { (alert) -> Void in
        let image = CIImage(image: self.imageView.image)
        
        let sepiaFilter = CIFilter(name: "CISepiaTone")
        sepiaFilter.setValue(image, forKey: kCIInputImageKey)
        
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
        
        let outputImage = sepiaFilter.outputImage
        let extent = outputImage.extent()
        
        let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
        let finalImage = UIImage(CGImage: cgImage)
        self.imageView.image = finalImage
      }
      let transferAction = UIAlertAction(title: "Transfer", style: UIAlertActionStyle.Default) { (alert) -> Void in
        let image = CIImage(image: self.imageView.image)
        
        let transferFilter = CIFilter(name: "CIPhotoEffectTransfer")
        transferFilter.setValue(image, forKey: kCIInputImageKey)
        
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
        
        let outputImage = transferFilter.outputImage
        let extent = outputImage.extent()
        
        let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
        let finalImage = UIImage(CGImage: cgImage)
        self.imageView.image = finalImage
      }
      let fadeAction = UIAlertAction(title: "Fade", style: UIAlertActionStyle.Default) { (alert) -> Void in
        let image = CIImage(image: self.imageView.image)
        
        let fadeFilter = CIFilter(name: "CIPhotoEffectFade")
        fadeFilter.setValue(image, forKey: kCIInputImageKey)
        
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
        
        let outputImage = fadeFilter.outputImage
        let extent = outputImage.extent()
        
        let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
        let finalImage = UIImage(CGImage: cgImage)
        self.imageView.image = finalImage
      }
      let unsharpAction = UIAlertAction(title: "Sharpen", style: UIAlertActionStyle.Default) { (alert) -> Void in
        let image = CIImage(image: self.imageView.image)
        
        let unsharpFilter = CIFilter(name: "CIUnsharpMask")
        unsharpFilter.setValue(image, forKey: kCIInputImageKey)
        
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
        
        let outputImage = unsharpFilter.outputImage
        let extent = outputImage.extent()
        
        let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
        let finalImage = UIImage(CGImage: cgImage)
        self.imageView.image = finalImage
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
      
      alert.addAction(uploadAction)
      alert.addAction(photoLibraryAction)
      alert.addAction(cancelAction)
      alert.addAction(sepiaAction)
      alert.addAction(chromeAction)
      alert.addAction(transferAction)
      alert.addAction(fadeAction)
      alert.addAction(unsharpAction)


      self.picker.delegate = self
      self.picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
      
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
  func enterFilterMode(){
    collectionViewBottomConstraint.constant = 0
    
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "closeCollectionViewMode")
    navigationItem.rightBarButtonItem = doneButton
  }
  func closeCollectionViewMode() {
      collectionViewBottomConstraint.constant = -150
      
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

