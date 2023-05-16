//
//  DIcon.swift
//  Designify
//
//  Created by Milton Palaguachi on 5/9/23.
//

import UIKit
import SwiftUI

/// Designify Icon
public enum DIcon: CaseIterable {
    case barcode
    case cart
    case card
    case plush
    case pokemon

    private var assetName: String {
        switch self {
            case .barcode: return "Barcode"
            case .cart: return "Cart"
            case .card: return "Card"
            case .plush: return "Plush"
            case .pokemon: return "Pokemon"
        }
    }

    public var iconAccessibilityLabel: String {
        assetName
    }
}

extension DIcon {
    /// Returns `DIcon` as UIImage.
    public var uiImage: UIImage {
        let image = UIImage.coreDImage(named: assetName)?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        image.accessibilityIdentifier = iconAccessibilityLabel
        return image
    }

    /// Returns `DIcon` as Image.
    public var image: Image {
        let image = Image.coreDImage(named: assetName)
        return image
            .accessibility(label: Text(iconAccessibilityLabel))
            .content
            .renderingMode(.original)
    }

    public func uiImage(_ size: DIconDimention) -> UIImage {
        Self.getOrCreateIcon(self, for: size)
    }
    
}

/// Private Helper Methods
extension DIcon {
    private static var imageCache = NSCache<NSString, UIImage>()

    private func createImage(size: DIconDimention) -> UIImage {
        uiImage.resizeTo(targetSize: size.cgSize).withRenderingMode(.alwaysOriginal)
    }

    static func getOrCreateIcon(_ icon: DIcon, for size: DIconDimention) -> UIImage {
        let cacheKey = icon.assetName.appendingFormat("%.2f", size.cgSize.width) as NSString
        if let cache = imageCache.object(forKey: cacheKey) {
            return cache
        }
        let createIcon = icon.createImage(size: size)
        imageCache.setObject(createIcon, forKey: cacheKey)
        return createIcon
    }
}

#if DEBUG
extension DIcon {
    struct TestHooks {
        func clearCache() {
            DIcon.imageCache.removeAllObjects()
        }
    }
}

#endif
