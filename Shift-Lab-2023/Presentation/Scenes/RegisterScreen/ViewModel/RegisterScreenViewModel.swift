//
//  RegisterScreenViewModel.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import Foundation

protocol RegisterScreenViewModel {

    // MARK: - Input

    func goToEventsScreen()
    func updateName(_ name: String)
    func updateSurname(_ surname: String)
    func updateDateOfBirth(_ dateOfBirth: Date) -> String
    func updatePassword(_ password: String)
    func updateConfirmPassword(_ confirmPassword: String)
    func registerUser()

    // MARK: - Output

    var error: Dynamic<String> { get }

}

final class RegisterScreenViewModelImpl: RegisterScreenViewModel {

    // MARK: - Public Properties

    public weak var sceneDelegate: RegisterScreenSceneDelegate?

    public var name: String = ""
    public var surname: String = ""
    public var dateOfBirth: Date? = nil
    public var password: String = ""
    public var confirmPassword: String = ""

    // MARK: - Private Properties

    private let dependencies: Dependencies

    // MARK: - Init

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Input

    public func goToEventsScreen() {
        sceneDelegate?.goToEventsScreen()
    }

    public func updateName(_ name: String) {
        self.name = name
    }

    public func updateSurname(_ surname: String) {
        self.surname = surname
    }

    public func updateDateOfBirth(_ dateOfBirth: Date) -> String {
        self.dateOfBirth = dateOfBirth
        return dependencies.convertDateToStringUseCase.invoke(dateOfBirth)
    }

    public func updatePassword(_ password: String) {
        self.password = password
    }

    public func updateConfirmPassword(_ confirmPassword: String) {
        self.confirmPassword = confirmPassword
    }

    public func registerUser() {
        if let error = dependencies.getRegisterErrorUseCase.invoke(
            name: name,
            surname: surname,
            dateOfBirth: dateOfBirth,
            password: password,
            confirmPassword: confirmPassword
        ) {
            self.error.value = error
        } else {
            dependencies.saveUserNameUseCase.invoke(name)
            goToEventsScreen()
        }
    }

    // MARK: - Output

    public var error: Dynamic<String> = .init(.init())

    // MARK: - Private Methods

    private func saveUserName() {
        dependencies.saveUserNameUseCase.invoke(name)
    }

}

// MARK: - Nested Types

extension RegisterScreenViewModelImpl {
    struct Dependencies {
        let convertDateToStringUseCase: ConvertDateToStringUseCase
        let getRegisterErrorUseCase: GetRegisterErrorUseCase
        let saveUserNameUseCase: SaveUserNameUseCase
    }
}
