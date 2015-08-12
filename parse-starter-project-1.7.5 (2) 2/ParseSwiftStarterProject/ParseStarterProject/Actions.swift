//
//  Actions.swift
//  ParseStarterProject
//
//  Created by Kristen Kozmary on 8/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

//class Actions {
//  class func filterAction(action: UIAlertAction, image: UIImage, filter: CIFilter) -> UIImage {
//    let chromeAction = UIAlertAction(title: "Chrome", style: UIAlertActionStyle.Default) { (alert) -> Void in
//      let image = CIImage(image: self.imageView.image)
//      let chromeFilter = CIFilter(name: "CIPhotoEffectChrome")
//      chromeFilter.setValue(image, forKey: kCIInputImageKey)
//    
//      let options = [kCIContextWorkingColorSpace: NSNull()]
//      let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//      let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
//    
//      let outputImage = chromeFilter.outputImage
//      let extent = outputImage.extent()
//    
//      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
//      let finalImage = UIImage(CGImage: cgImage)
//      self.imageView.image = finalImage
//  }
//}

//
//let chromeAction = UIAlertAction(title: "Chrome", style: UIAlertActionStyle.Default) { (alert) -> Void in
//  let image = CIImage(image: self.imageView.image)
//  let chromeFilter = CIFilter(name: "CIPhotoEffectChrome")
//  chromeFilter.setValue(image, forKey: kCIInputImageKey)
//  
//  let options = [kCIContextWorkingColorSpace: NSNull()]
//  let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//  let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
//  
//  let outputImage = chromeFilter.outputImage
//  let extent = outputImage.extent()
//  
//  let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
//  let finalImage = UIImage(CGImage: cgImage)
//  self.imageView.image = finalImage
//}
//let sepiaAction = UIAlertAction(title: "Sepia", style: UIAlertActionStyle.Default) { (alert) -> Void in
//  let image = CIImage(image: self.imageView.image)
//  
//  let sepiaFilter = CIFilter(name: "CISepiaTone")
//  sepiaFilter.setValue(image, forKey: kCIInputImageKey)
//  
//  let options = [kCIContextWorkingColorSpace: NSNull()]
//  let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//  let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
//  
//  let outputImage = sepiaFilter.outputImage
//  let extent = outputImage.extent()
//  
//  let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
//  let finalImage = UIImage(CGImage: cgImage)
//  self.imageView.image = finalImage
//}
//let transferAction = UIAlertAction(title: "Transfer", style: UIAlertActionStyle.Default) { (alert) -> Void in
//  let image = CIImage(image: self.imageView.image)
//  
//  let transferFilter = CIFilter(name: "CIPhotoEffectTransfer")
//  transferFilter.setValue(image, forKey: kCIInputImageKey)
//  
//  let options = [kCIContextWorkingColorSpace: NSNull()]
//  let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//  let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
//  
//  let outputImage = transferFilter.outputImage
//  let extent = outputImage.extent()
//  
//  let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
//  let finalImage = UIImage(CGImage: cgImage)
//  self.imageView.image = finalImage
//}
//let fadeAction = UIAlertAction(title: "Fade", style: UIAlertActionStyle.Default) { (alert) -> Void in
//  let image = CIImage(image: self.imageView.image)
//  
//  let fadeFilter = CIFilter(name: "CIPhotoEffectFade")
//  fadeFilter.setValue(image, forKey: kCIInputImageKey)
//  
//  let options = [kCIContextWorkingColorSpace: NSNull()]
//  let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//  let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
//  
//  let outputImage = fadeFilter.outputImage
//  let extent = outputImage.extent()
//  
//  let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
//  let finalImage = UIImage(CGImage: cgImage)
//  self.imageView.image = finalImage
//}
//let unsharpAction = UIAlertAction(title: "Sharpen", style: UIAlertActionStyle.Default) { (alert) -> Void in
//  let image = CIImage(image: self.imageView.image)
//  
//  let unsharpFilter = CIFilter(name: "CIUnsharpMask")
//  unsharpFilter.setValue(image, forKey: kCIInputImageKey)
//  
//  let options = [kCIContextWorkingColorSpace: NSNull()]
//  let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//  let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
//  
//  let outputImage = unsharpFilter.outputImage
//  let extent = outputImage.extent()
//  
//  let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
//  let finalImage = UIImage(CGImage: cgImage)
//  self.imageView.image = finalImage
//}
//
//alert.addAction(sepiaAction)
//alert.addAction(chromeAction)
//alert.addAction(transferAction)
//alert.addAction(fadeAction)
//alert.addAction(unsharpAction)

