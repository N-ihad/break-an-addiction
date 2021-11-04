//
//  Date.swift
//  Break an Addiction
//
//  Created by Nihad on 11/4/21.
//

import Foundation
import UIKit

extension Date {
    static var yesterday: Date {
        Date().dayBefore
    }

    static var tomorrow:  Date {
        Date().dayAfter
    }

    var dayBefore: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }

    var dayAfter: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }

    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var month: Int {
        Calendar.current.component(.month,  from: self)
    }

    var isLastDayOfMonth: Bool {
        dayAfter.month != month
    }

    var toString: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let relapseDateInString = formatter.string(from: self)

        return relapseDateInString
    }
}
