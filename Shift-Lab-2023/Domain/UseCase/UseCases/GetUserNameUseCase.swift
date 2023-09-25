//
//  GetUserNameUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class GetUserNameUseCase {

    // MARK: - Private Properties

    private let userInfoStorage: UserInfoStorage

    // MARK: - Init

    public init(userInfoStorage: UserInfoStorage) {
        self.userInfoStorage = userInfoStorage
    }

    // MARK: - UseCase

    public func invoke() -> String {
        return userInfoStorage.name.orEmpty
    }

}
