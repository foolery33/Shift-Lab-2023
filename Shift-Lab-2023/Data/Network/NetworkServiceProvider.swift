//
//  NetworkServiceProvider.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class NetworkServiceProvider {

    // MARK: - Instances

    public lazy var contestService: ContestService = {
        return ContestServiceImpl()
    }()

}
