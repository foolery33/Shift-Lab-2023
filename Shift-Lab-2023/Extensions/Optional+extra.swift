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

extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}


extension Optional {
    func orEmptyArray<T>() -> [T] where Wrapped == [T] {
        return self ?? []
    }
}
