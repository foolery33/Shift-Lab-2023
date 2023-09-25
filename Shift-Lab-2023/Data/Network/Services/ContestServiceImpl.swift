//
//  ContestServiceImpl.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class ContestServiceImpl: BaseNetworkService, ContestService {
    func getContests(
        completion: @escaping (
            (Result<[ContestResponse], Error>) -> Void
        )
    ) {
        request(
            method: .get,
            url: URLFactory.Contest.all,
            outputModel: [ContestResponse].self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
