//
//  GetContestsUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class GetContestsUseCase {

    // MARK: - Private Properties

    private let contestRepository: ContestRepository

    // MARK: - Init

    public init(contestRepository: ContestRepository) {
        self.contestRepository = contestRepository
    }

    // MARK: - UseCase

    public func invoke(
        completion: @escaping (
            (Result<[ContestDomain], Error>) -> Void
        )
    ) {
        contestRepository.getContests { result in
            switch result {
            case .success(let domain):
                completion(.success(domain))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
