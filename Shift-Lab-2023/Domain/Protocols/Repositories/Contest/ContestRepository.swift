//
//  ContestRepository.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

protocol ContestRepository {
    func getContests(
        completion: @escaping (
            (Result<[ContestDomain], Error>) -> Void
        )
    )
}
