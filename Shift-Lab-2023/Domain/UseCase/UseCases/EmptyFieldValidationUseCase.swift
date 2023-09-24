//
//  EmptyFieldValidationUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class EmptyFieldValidationUseCase {

    // MARK: - UseCase

    public func invoke(_ field: String) -> Bool {
        return field.isEmpty
    }

}
