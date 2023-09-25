//
//  URLFactory.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

struct URLFactory {
    private static let baseURL = "https://kontests.net/api"

    struct APIVersion {
        static let v1 = "/v1"
    }

    struct Contest {
        static let all = baseURL + APIVersion.v1 + "/all"
    }
}
