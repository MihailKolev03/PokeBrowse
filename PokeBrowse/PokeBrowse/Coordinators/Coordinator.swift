//
//  Coordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation
import SwiftUI

protocol Coordinator: AnyObject {

    @ViewBuilder
    func start() -> AnyView

    var childCoordinators: [Coordinator] { get set }
    func addChild(coordinator: Coordinator)
    func removeChild(coordinator: Coordinator)
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
