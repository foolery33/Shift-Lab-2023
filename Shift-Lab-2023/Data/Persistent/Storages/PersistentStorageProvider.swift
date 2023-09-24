//
//  PersistentStorageProvider.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class PersistentStorageProvider {

    // MARK: - Private Properties

    private let userDefaultsStandard = UserDefaults.standard

    // MARK: - Instances

    public lazy var userInfoStorage: UserInfoStorage = {
        UserInfoStorageImpl(userDefaultsStandard: userDefaultsStandard)
    }()

}
