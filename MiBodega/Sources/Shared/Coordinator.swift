//
//  Coordinator.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/3/23.
//

import Foundation
import SwiftUI

open class Coordinator: ObservableObject {
    func start(){
        assertionFailure("start() should not be called directly. it needs to be overriden on the inherited class")
    }
}
