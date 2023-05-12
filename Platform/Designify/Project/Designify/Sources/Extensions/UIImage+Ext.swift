//
//  UIImage+Ext.swift
//  Designify
//
//  Created by Milton Palaguachi on 5/9/23.
//

import UIKit

extension UIImage {
    /// Loads an image from the Designify assets bundle
    public static func coreDImage(named name: String) -> UIImage? {
        UIImage(named: name, in: .designifyModule, compatibleWith: nil)
    }
}

/// credit: https://www.advancedswift.com/resize-uiimage-no-stretching-swift/
extension UIImage {
    public func resizeTo(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRation = targetSize.width / size.width
        let heighRation = targetSize.height / size.height
        let scaleFactor = min(widthRation, heighRation)

        // To keep the aspect ratio, scale by the smaller scaling ratio
        var newSize = CGSize(width: scaleFactor * size.width, height: scaleFactor * size.height)

        // Draw and return the resized UIImage
        let rect = CGRect(origin: .zero, size: newSize)
        let render = UIGraphicsImageRenderer(size: newSize)
        let newImage = render.image { [weak self] _ in
            self?.draw(in: rect)
        }
        return newImage
    }
}

extension UIImage {
    public func imageWith(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: .zero, size: size)
        color.setFill()
        draw(in: rect)
        context?.setBlendMode(.sourceIn)
        context?.fill(rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        UIGraphicsEndImageContext()
        return newImage
    }
}
