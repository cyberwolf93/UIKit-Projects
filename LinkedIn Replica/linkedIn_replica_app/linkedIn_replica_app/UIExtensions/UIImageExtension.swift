//
//  UIImageExtension.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 07/02/2023.
//

import UIKit

extension UIImage {
    static func resizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
        guard let image else {return nil}
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func loadLocalImageWith(name: String) -> UIImage? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "jpg") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {return nil}
        return UIImage(data: data)
    }
}
