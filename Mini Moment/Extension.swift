//
//  Extension.swift
//  Mini Moment
//
//  Created by han xu on 2016-04-10.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    // tap to dismiss keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // set image as screen background
    func assignBlurbackground(image: UIImage, isBlur: Bool){
        let background = image
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        /* add blur effect to background image*/
        if isBlur{
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = imageView.bounds
            imageView.addSubview(blurEffectView)
        }
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController!
        } else {
            return self
        }
    }
}

extension UIImageView
{
    func roundCornersForAspectFit(radius: CGFloat)
    {
        if let image = self.image {
            
            //calculate drawingRect
            let boundsScale = self.bounds.size.width / self.bounds.size.height
            let imageScale = image.size.width / image.size.height
            
            var drawingRect : CGRect = self.bounds
            
            if boundsScale > imageScale {
                drawingRect.size.width =  drawingRect.size.height * imageScale
                drawingRect.origin.x = (self.bounds.size.width - drawingRect.size.width) / 2
            }else{
                drawingRect.size.height = drawingRect.size.width / imageScale
                drawingRect.origin.y = (self.bounds.size.height - drawingRect.size.height) / 2
            }
            let path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
            let mask = CAShapeLayer()
            mask.path = path.CGPath
            self.layer.mask = mask
        }
    }
}

struct PostType {
    static let Say = "say"
    static let Photo = "photo"
    static let Video = "video"
}