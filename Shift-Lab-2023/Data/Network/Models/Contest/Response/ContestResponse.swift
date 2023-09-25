//
//  ContestResponse.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

struct ContestResponse: Decodable {
    let name: String
    let url: String
    let startTime: String
    let endTime: String
}
