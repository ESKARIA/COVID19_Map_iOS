//
//  GMSMarker+Extension.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 17.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import Foundation
import GoogleMaps

extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}
