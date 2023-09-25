//
//  NetworkServiceError.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

enum NetworkServiceError: Error {
  case badRequest
  case unauthorized
  case forbidden
  case notFound
  case methodNotAllowed
  case conflict
  case internalServerError
  case badGateway
  case serviceUnavailable
  case gatewayTimeout
  case dataMapping
  case notConnectedToInternet
  case timeout
  case networkConnectionLost
  case unknown
}

extension NetworkServiceError: LocalizedError {
    // TODO: Локализовать
    var errorDescription: String? {
      switch self {
      case .badRequest:
        return ""
      case .unauthorized:
        return ""
      case .forbidden:
        return ""
      case .notFound:
        return ""
      case .methodNotAllowed:
        return ""
      case .conflict:
        return ""
      case .internalServerError:
        return ""
      case .badGateway:
        return ""
      case .serviceUnavailable:
        return ""
      case .gatewayTimeout:
        return ""
      case .dataMapping:
        return ""
      case .notConnectedToInternet:
        return ""
      case .timeout:
        return ""
      case .networkConnectionLost:
        return ""
      case .unknown:
        return ""
      }
    }
}
