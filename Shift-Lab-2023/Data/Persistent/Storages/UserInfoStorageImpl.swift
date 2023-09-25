//
//  UserInfoStorageImpl.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class UserInfoStorageImpl {

    // MARK: - Private Properties

    private let userDefaultsStandard: UserDefaults

    // MARK: - Init

    public init(userDefaultsStandard: UserDefaults) {
        self.userDefaultsStandard = userDefaultsStandard
    }

}

// MARK: - UserInfoStorage

extension UserInfoStorageImpl: UserInfoStorage {

    // MARK: - Public Properties

    public var name: String? {
        userDefaultsStandard.string(forKey: StorageKey.name.rawValue)
    }

    func saveName(_ name: String) {
        userDefaultsStandard.set(name, forKey: StorageKey.name.rawValue)
    }

    func removeName() {
        userDefaultsStandard.removeObject(forKey: StorageKey.name.rawValue)
    }

    func clearStorage() {
        let dictionary = userDefaultsStandard.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefaultsStandard.removeObject(forKey: key)
        }
    }


}
