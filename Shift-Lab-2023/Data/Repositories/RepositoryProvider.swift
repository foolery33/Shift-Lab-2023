//
//  RepositoryProvider.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class RepositoryProvider {

    // MARK: - Private Properties

    private let networkServiceProvider: NetworkServiceProvider

    // MARK: - Init

    public init(networkServiceProvider: NetworkServiceProvider) {
        self.networkServiceProvider = networkServiceProvider
    }

    // MARK: - Instances

    public lazy var contestRepository: ContestRepository = {
        return ContestRepositoryImpl(
            contestService: networkServiceProvider.contestService,
            contestMapper: .init()
        )
    }()

}
