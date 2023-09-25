//
//  UseCaseProvider.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class UseCaseProvider {

    // MARK: - Singleton

    private init() {}

    static let instance = UseCaseProvider()

    // MARK: - Private Properties

    private let persistentStorageProvider: PersistentStorageProvider = .init()

    private lazy var repositoryProvider: RepositoryProvider = .init(
        networkServiceProvider: networkServiceProvider
    )

    private let networkServiceProvider: NetworkServiceProvider = .init()

    // MARK: - Instances

    public lazy var convertDateToStringUseCase: ConvertDateToStringUseCase = {
        .init()
    }()

    public lazy var emptyFieldValidationUseCase: EmptyFieldValidationUseCase = {
        .init()
    }()

    public lazy var nameValidationUseCase: NameValidationUseCase = {
        .init()
    }()

    public lazy var surnameValidationUseCase: SurnameValidationUseCase = {
        .init()
    }()

    public lazy var passwordValidationUseCase: PasswordValidationUseCase = {
        .init()
    }()

    public lazy var passwordsEqualityValidationUseCase: PasswordsEqualityValidationUseCase = {
        .init()
    }()

    public lazy var getRegisterErrorUseCase: GetRegisterErrorUseCase = {
        .init(
            emptyFieldValidationUseCase: emptyFieldValidationUseCase,
            nameValidationUseCase: nameValidationUseCase,
            surnameValidationUseCase: surnameValidationUseCase,
            passwordValidationUseCase: passwordValidationUseCase,
            passwordsEqualityValidationUseCase: passwordsEqualityValidationUseCase
        )
    }()

    public lazy var saveUserNameUseCase: SaveUserNameUseCase = {
        .init(userInfoStorage: persistentStorageProvider.userInfoStorage)
    }()

    public lazy var getContestsUseCase: GetContestsUseCase = {
        .init(contestRepository: repositoryProvider.contestRepository)
    }()

    public lazy var getDateFromStringUseCase: GetDateFromStringUseCase = {
        .init()
    }()

    public lazy var getTimeRangeUseCase: GetTimeRangeUseCase = {
        .init()
    }()

    public lazy var getUserNameUseCase: GetUserNameUseCase = {
        .init(userInfoStorage: persistentStorageProvider.userInfoStorage)
    }()

}
