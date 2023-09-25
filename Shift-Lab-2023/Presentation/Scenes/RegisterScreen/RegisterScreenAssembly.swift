//
//  RegisterScreenAssembly.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import UIKit

enum RegisterScreenAssembly {
    public static func make(
        with sceneDelegate: RegisterScreenSceneDelegate
    ) -> RegisterScreenViewController {
        let viewModel = RegisterScreenViewModelImpl(
            dependencies: .init(
                convertDateToStringUseCase: UseCaseProvider.instance.convertDateToStringUseCase,
                getRegisterErrorUseCase: UseCaseProvider.instance.getRegisterErrorUseCase,
                saveUserNameUseCase: UseCaseProvider.instance.saveUserNameUseCase
            )
        )
        viewModel.sceneDelegate = sceneDelegate

        let viewController = RegisterScreenViewController(viewModel: viewModel)
        return viewController
    }
}
