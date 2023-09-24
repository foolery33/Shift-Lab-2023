//
//  PasswordsEqualityValidationUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class PasswordsEqualityValidationUseCase {

    // MARK: - UseCase

    public func invoke(_ password: String, _ confirmPassword: String) -> Bool {
        return password == confirmPassword
    }

}
