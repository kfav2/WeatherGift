import UIKit

let unixDate: TimeInterval = 1642010500
let usableDate = Date(timeIntervalSince1970: unixDate)

print(usableDate)

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .long
dateFormatter.timeStyle = .long

var dateString = dateFormatter.string(from: usableDate)
print(dateString)

let timeZone = TimeZone(identifier: "Australia/Sydney")
dateFormatter.timeZone = timeZone
dateString = dateFormatter.string(from: usableDate)
print(dateString)

// Wednesday, Jan 12, 2022
dateFormatter.dateFormat = "EEEE, MMM, d"
dateString = dateFormatter.string(from: usableDate)
print(dateString)
