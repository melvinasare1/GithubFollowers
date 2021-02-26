//
//  StringExtension.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 17/02/2021.
//

import Foundation

extension String {

    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)!
    }

    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A"}
        return date.convertToDateMonthYearFormat()
    }
}
