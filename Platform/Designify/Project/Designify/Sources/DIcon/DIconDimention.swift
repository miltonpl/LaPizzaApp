//
//  DIconDimention.swift
//  Designify
//
//  Created by Milton Palaguachi on 5/9/23.
//

import Foundation

public enum DIconDimention: Equatable {
    case small, medium, large

    public var cgSize: CGSize {
        CGSize(width: dimension, height: dimension)
    }

    public var dimension: CGFloat {
        switch self {
            case .small: return 16
            case .medium: return 24
            case .large: return 32
        }
    }
}
