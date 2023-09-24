//
//  NameValidationUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class NameValidationUseCase {

    // MARK: - UseCase

    public func invoke(_ name: String) -> Bool {
        let nameRegex = "[А-ЯЁ][а-яё]*|[A-Z][a-z]*"
        let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name) && name.count >= 2
    }

}
