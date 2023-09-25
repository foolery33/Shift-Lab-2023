//
//  GetDateRangeUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

class GetDateFromStringUseCase {

    // MARK: - UseCase

    public func invoke(dateString: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd.MM.yyyy"

        if let date = dateFormatterInput.date(from: dateString) {
           let formattedDate = dateFormatterOutput.string(from: date)
            return formattedDate
        }

        return "N/D"
    }

}
