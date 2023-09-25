//
//  EventsCoordinator.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import UIKit

final class EventsCoordinator: BaseNavigationCoordinator {

    // MARK: - Init

    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }

    // MARK: - Start

    override func start() {
        startEventsScreen()
    }

    // MARK: - Private Methods

    private func startEventsScreen() {
        let viewController = EventsScreenAssembly.make()
        navigationController.pushViewController(viewController, animated: true)
    }

}
