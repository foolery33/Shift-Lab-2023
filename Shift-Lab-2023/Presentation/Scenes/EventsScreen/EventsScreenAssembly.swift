//
//  EventsScreenAssembly.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

enum EventsScreenAssembly {
    static func make() -> EventsScreenViewController {
        let viewModel = EventsScreenViewModelImpl(
            dependencies: .init(
                getContestsUseCase: UseCaseProvider.instance.getContestsUseCase,
                getDateFromStringUseCase: UseCaseProvider.instance.getDateFromStringUseCase,
                getTimeRangeUseCase: UseCaseProvider.instance.getTimeRangeUseCase,
                getUserNameUseCase: UseCaseProvider.instance.getUserNameUseCase
            )
        )

        let viewController = EventsScreenViewController(viewModel: viewModel)
        return viewController
    }
}
