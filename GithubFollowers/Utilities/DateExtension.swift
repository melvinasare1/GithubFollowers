//
//  DateExtension.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 17/02/2021.
//

import Foundation

extension Date {

    func convertToDateMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyy"
        return dateFormatter.string(from: self)
    }
}
