//
//  BaseNavigationCoordinator.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import UIKit

class BaseNavigationCoordinator: Coordinator {
    // MARK: - Properties
    private var _children: [Coordinator] = []

    let navigationController: UINavigationController

    // MARK: - Coordinator Properties
    var rootViewController: UIViewController {
        navigationController
    }

    var children: [Coordinator] {
        _children
    }

    // MARK: - Constructor
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods
    func add(child coordinator: Coordinator) {
        _children.append(coordinator)
    }

    func remove(child coordinator: Coordinator) {
        _children = _children.filter { coordinator !== $0 }
    }

    // MARK: - Coordinator Methods
    func start() {
        fatalError("this method must be overridden")
    }
}
