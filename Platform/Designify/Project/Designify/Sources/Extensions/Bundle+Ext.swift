//
//  Bundle+Ext.swift
//  Designify
//
//  Created by Milton Palaguachi on 5/9/23.
//

import Foundation

private final class Designify { }

extension Bundle {
    static var designify: Bundle {
        moduleBundle(for: Designify.self)
    }
}

extension Bundle {
    public static func moduleBundle(for object: AnyObject) -> Bundle! {
        Bundle.moduleBundle(forObject: object)
    }

    public static func moduleBundle(forObject: AnyObject) -> Bundle {
        Bundle(for: type(of: forObject))
    }
}
