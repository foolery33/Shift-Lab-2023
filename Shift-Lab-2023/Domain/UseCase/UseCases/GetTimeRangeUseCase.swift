//
//  GetTimeRangeUseCase.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

final class GetTimeRangeUseCase {

    // MARK: - UseCase

    public func invoke(timeString1: String, timeString2: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "HH:mm"

        if let time1 = dateFormatterInput.date(from: timeString1),
           let time2 = dateFormatterInput.date(from: timeString2) {
            let formattedTime1 = dateFormatterOutput.string(from: time1)
            let formattedTime2 = dateFormatterOutput.string(from: time2)
            return "\(formattedTime1)-\(formattedTime2)"
        }

        return "N/D - N/D"
    }

}
