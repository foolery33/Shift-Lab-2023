//
//  ContestService.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

protocol ContestService {
    func getContests(
        completion: @escaping (
            (Result<[ContestResponse], Error>) -> Void
        )
    )
}
