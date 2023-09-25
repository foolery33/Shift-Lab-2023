//
//  ContestRepositoryImpl.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

final class ContestRepositoryImpl {

    // MARK: - Private Properties

    private let contestService: ContestService

    private let contestMapper: ContestMapper

    // MARK: - Init

    public init(
        contestService: ContestService,
        contestMapper: ContestMapper
    ) {
        self.contestService = contestService
        self.contestMapper = contestMapper
    }

}

// MARK: - ContestRepository

extension ContestRepositoryImpl: ContestRepository {
    func getContests(
        completion: @escaping (
            (Result<[ContestDomain], Error>) -> Void
        )
    ) {
        contestService.getContests { [weak self] result in
            switch result {
            case .success(let response):
                completion(
                    .success(
                        response.map {
                            self?.contestMapper.call($0) ?? .init()
                        }
                    )
                )

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
