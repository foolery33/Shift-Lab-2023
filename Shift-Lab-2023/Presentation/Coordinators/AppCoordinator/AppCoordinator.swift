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
//        startRegisterFlow()
        startEventsFlow()
    }

    // MARK: - Private Methods

    private func startRegisterFlow() {
        let coordinator = RegisterCoordinator(navigationController: navigationController)

        coordinator.onRouteToEventsFlow = { [weak self] registerCoordinator in
            self?.remove(child: registerCoordinator)
            self?.startEventsFlow()
        }
        add(child: coordinator)
        coordinator.start()
    }

    private func startEventsFlow() {
        let coordinator = EventsCoordinator(navigationController: navigationController)

        add(child: coordinator)
        coordinator.start()
    }

}
