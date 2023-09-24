//
//  Optional+extra.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }

    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
