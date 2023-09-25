//
//  BaseNetworkService.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Alamofire
import Foundation

struct VoidDecodable: Decodable {}

class BaseNetworkService {
    private let jsonDecoder = JSONDecoder()

    func request<T: Decodable>(
        method: HTTPMethod,
        url: URLConvertible,
        parameters: Parameters? = nil,
        outputModel: T.Type,
        completion: @escaping (
            (Result<T, Error>) -> Void
        )
    ) {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let request = AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default
        )
        request.responseData { response in
            if let code = response.response?.statusCode {
                let result = response.result
                let statusCode = HTTPStatusCode(rawValue: code)

                let handleResult = self.handleResponse(
                    result: result,
                    outputModel: T.self,
                    statusCode: statusCode ?? .internalServerError
                )

                switch handleResult {
                case .success(let response):
                    completion(.success(response))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func handleResponse<T>(
        result: Result<Data, AFError>,
        outputModel: T.Type,
        statusCode: HTTPStatusCode
    ) -> Result<T, Error> where T: Decodable {
        switch result {
        case .success(let data):
            switch statusCode {
            case .okStatus, .created, .accepted, .noContent:
                guard let output = try? jsonDecoder.decode(
                    outputModel.self,
                    from: data
                ) else {
                    return .failure(NetworkServiceError.dataMapping)
                }
                return .success(output)

            default:
                return .failure(
                    makePresentationError(statusCode: statusCode, data: data)
                )
            }

        case .failure(let error):
            return .failure(
                convertToPresentationError(error)
            )
        }
    }

    private func makePresentationError(
        statusCode: HTTPStatusCode,
        data: Data
    ) -> Error {
        switch statusCode {
        case .badRequest:
            return NetworkServiceError.badRequest
        case .unauthorized:
            return NetworkServiceError.unauthorized
        case .forbidden:
            return NetworkServiceError.forbidden
        case .notFound:
            return NetworkServiceError.notFound
        case .methodNotAllowed:
            return NetworkServiceError.methodNotAllowed
        case .conflict:
            return NetworkServiceError.conflict
        case .internalServerError:
            return NetworkServiceError.internalServerError
        case .badGateway:
            return NetworkServiceError.badGateway
        case .serviceUnavailable:
            return NetworkServiceError.serviceUnavailable
        case .gatewayTimeout:
            return NetworkServiceError.gatewayTimeout
        default:
            return NetworkServiceError.unknown
        }
    }

    private func convertToPresentationError(_ urlError: URLError) -> Error {
        switch urlError {
        case URLError.notConnectedToInternet, URLError.dataNotAllowed:
            return NetworkServiceError.notConnectedToInternet

        case URLError.timedOut:
            return NetworkServiceError.timeout

        case URLError.networkConnectionLost:
            return NetworkServiceError.networkConnectionLost

        default:
            return NetworkServiceError.unknown
        }
    }

    private func convertToPresentationError(_ alamofireError: AFError) -> Error {
        switch alamofireError {
        case
                .createUploadableFailed,
                .createURLRequestFailed,
                .downloadedFileMoveFailed,
                .explicitlyCancelled,
                .invalidURL,
                .requestAdaptationFailed,
                .requestRetryFailed,
                .responseValidationFailed,
                .serverTrustEvaluationFailed,
                .sessionDeinitialized,
                .urlRequestValidationFailed:
            return NetworkServiceError.unknown

        case
                .multipartEncodingFailed,
                .parameterEncodingFailed,
                .parameterEncoderFailed:
            return NetworkServiceError.dataMapping

        case .responseSerializationFailed:
            return NetworkServiceError.dataMapping

        case let .sessionInvalidated(error: error):
            if let error = error as? URLError {
                return convertToPresentationError(error)
            }
            return NetworkServiceError.unknown

        case let .sessionTaskFailed(error: error):
            if let error = error as? URLError {
                return convertToPresentationError(error)
            }
            return NetworkServiceError.unknown
        }
    }
}
