//
//  PasswordValidationUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class PasswordValidationUseCase {

    // MARK: - UseCase

    public func invoke(_ password: String) -> Bool {
        guard password.count >= 6 else {
            return false
        }
        // Проверка наличия только латинских букв и цифр
        let alphanumericCharacterSet = CharacterSet.alphanumerics
        guard password.rangeOfCharacter(from: alphanumericCharacterSet.inverted) == nil else {
            return false
        }
        // Проверка наличия хотя бы одной заглавной буквы, строчной буквы и цифры
        let uppercaseLetterCharacterSet = CharacterSet.uppercaseLetters
        let lowercaseLetterCharacterSet = CharacterSet.lowercaseLetters
        let decimalDigitCharacterSet = CharacterSet.decimalDigits
        guard password.rangeOfCharacter(from: uppercaseLetterCharacterSet) != nil,
              password.rangeOfCharacter(from: lowercaseLetterCharacterSet) != nil,
              password.rangeOfCharacter(from: decimalDigitCharacterSet) != nil else {
            return false
        }
        return true
    }

}
