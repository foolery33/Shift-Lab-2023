//
//  RegisterCoordinator.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import UIKit

final class RegisterCoordinator: BaseNavigationCoordinator {

    // MARK: - Public Properties

    public var onRouteToEventsFlow: ((RegisterCoordinator) -> Void)?

    // MARK: - Init

    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }

    // MARK: - Start

    override func start() {
        startRegisterScreen()
    }

    // MARK: - Private Methods

    private func startRegisterScreen() {
        let viewController = RegisterScreenAssembly.make(with: self)
        navigationController.pushViewController(viewController, animated: true)
    }

}

// MARK: - RegisterScreenSceneDelegate

extension RegisterCoordinator: RegisterScreenSceneDelegate {
    func goToEventsScreen() {
        onRouteToEventsFlow?(self)
    }
}
