//
//  ContestMapper.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

struct ContestMapper: Mapper {
    typealias Response = ContestResponse
    typealias Domain = ContestDomain

    func call(_ response: Response) -> Domain {
        .init(
            name: response.name,
            url: response.url,
            startTime: response.startTime,
            endTime: response.endTime
        )
    }
}
