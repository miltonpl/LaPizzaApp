//
//  NSLayoutConstraint+Comlient.swift
//  MBPlatform
//
//  Created by Milton Palaguachi on 6/7/23.
//

import UIKit.NSLayoutConstraint

extension NSLayoutConstraint {
    /// A convinient mthod for changing  the `priority` from required to `requiredComplient`
    public func complient() -> NSLayoutConstraint {
        assert(priority == .required)
        priority = .requiredComplient
        return self
    }

    /// Set priority to self and return self
    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

extension UILayoutPriority {

    /// Priority to use in place of required. When there is a need to tolarate being temporarily zero-size.
    public static let requiredComplient = UILayoutPriority.required.decrease

    /// Gets the next higher than the current one
    public var increase: UILayoutPriority {
        return UILayoutPriority(rawValue: max(rawValue + 1, UILayoutPriority.required.rawValue + 1))
    }

    /// Gets the next lower than the current one
    public var decrease: UILayoutPriority {
        return UILayoutPriority(rawValue: max(0, rawValue - 1))
    }
}
