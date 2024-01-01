import Foundation

extension String {
    
    func toDate(dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? { //2022-06-14 09:56:44.169000
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale.init(identifier: "ne")
           dateFormatter.dateFormat = dateFormat
           return dateFormatter.date(from: self)
       }

}

extension Date {
    
    func toString(format: String = "d MMM yyyy 'at' h:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
