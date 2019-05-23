//
//  UIImage+Extension.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage? {
        let image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        }
        return image
    }
  
}
extension UIImageView {
    func setCustomImage(_ imgURLString: String?, defaultAvatar: String?) {
        if let url = URL(string: imgURLString!) as? URL
        {
            self.kf.setImage(with: url)
        }else{
            self.image = UIImage(named: "\(defaultAvatar)")
        }
    }
}
