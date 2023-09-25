//
//  GetRegisterErrorUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class GetRegisterErrorUseCase {

    // MARK: - Private Properties

    private let emptyFieldValidationUseCase: EmptyFieldValidationUseCase

    private let nameValidationUseCase: NameValidationUseCase

    private let surnameValidationUseCase: SurnameValidationUseCase

    private let passwordValidationUseCase: PasswordValidationUseCase

    private let passwordsEqualityValidationUseCase: PasswordsEqualityValidationUseCase

    // MARK: - Init

    public init(
        emptyFieldValidationUseCase: EmptyFieldValidationUseCase,
        nameValidationUseCase: NameValidationUseCase,
        surnameValidationUseCase: SurnameValidationUseCase,
        passwordValidationUseCase: PasswordValidationUseCase,
        passwordsEqualityValidationUseCase: PasswordsEqualityValidationUseCase
    ) {
        self.emptyFieldValidationUseCase = emptyFieldValidationUseCase
        self.nameValidationUseCase = nameValidationUseCase
        self.surnameValidationUseCase = surnameValidationUseCase
        self.passwordValidationUseCase = passwordValidationUseCase
        self.passwordsEqualityValidationUseCase = passwordsEqualityValidationUseCase
    }

    // MARK: - UseCase

    public func invoke(
        name: String,
        surname: String,
        dateOfBirth: Date?,
        password: String,
        confirmPassword: String
    ) -> String? {
        if emptyFieldValidationUseCase.invoke(name) {
            return "Поле 'имя' не заполнено"
        }
        if emptyFieldValidationUseCase.invoke(surname) {
            return "Поле 'фамилия' не заполнено"
        }
        if dateOfBirth == nil {
            return "Поле 'дата рождения' не заполнено"
        }
        if emptyFieldValidationUseCase.invoke(password) {
            return "Поле 'пароль' не заполнено"
        }
        if emptyFieldValidationUseCase.invoke(confirmPassword) {
            return "Поле 'подтверждение пароля' не заполнено"
        }

        if !nameValidationUseCase.invoke(name) {
            return R.string.localizable.name_validation_error()
        }
        if !surnameValidationUseCase.invoke(surname) {
            return R.string.localizable.surname_validation_error()
        }
        if !passwordValidationUseCase.invoke(password) {
            return R.string.localizable.password_validation_error()
        }

        if !passwordsEqualityValidationUseCase.invoke(password, confirmPassword) {
            return R.string.localizable.password_equality_error()
        }

        return nil
    }
    
}
