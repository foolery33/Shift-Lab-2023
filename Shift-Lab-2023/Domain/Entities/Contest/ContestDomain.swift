//
//  ContestDomain.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

struct ContestDomain {
    let name: String
    let url: String
    let startTime: String
    let endTime: String

    init(
        name: String,
        url: String,
        startTime: String,
        endTime: String
    ) {
        self.name = name
        self.url = url
        self.startTime = startTime
        self.endTime = endTime
    }

    init() {
        self.name = .init()
        self.url = .init()
        self.startTime = .init()
        self.endTime = .init()
    }
}
