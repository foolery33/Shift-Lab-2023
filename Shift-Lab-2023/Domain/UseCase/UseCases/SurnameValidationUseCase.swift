//
//  SurnameValidationUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class SurnameValidationUseCase {

    // MARK: - UseCase

    public func invoke(_ surname: String) -> Bool {
        let surnameRegex = "[А-ЯЁ][а-яё]*|[A-Z][a-z]*"
        let surnamePredicate = NSPredicate(format:"SELF MATCHES %@", surnameRegex)
        return surnamePredicate.evaluate(with: surname) && surname.count >= 2
    }

}
