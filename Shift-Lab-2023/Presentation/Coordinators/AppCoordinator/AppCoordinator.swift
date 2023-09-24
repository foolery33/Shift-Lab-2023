//
//  AppCoordinator.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import UIKit

final class AppCoordinator: BaseNavigationCoordinator {

    // MARK: - Init

    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }

    // MARK: - Start

    override func start() {
        startRegisterFlow()
    }

    // MARK: - Private Methods

    private func startRegisterFlow() {
        let coordinator = RegisterCoordinator(navigationController: navigationController)

        coordinator.onRouteToMainFlow = { [weak self] registerCoordinator in
            self?.remove(child: registerCoordinator)
            self?.startMainFlow()
        }
        add(child: coordinator)
        coordinator.start()
    }

    private func startMainFlow() {

    }

}
