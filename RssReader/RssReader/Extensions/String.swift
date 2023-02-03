import Foundation

extension String {
    func formated(from: String, to format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = from
        guard let date = formatter.date(from: self) else { return "" }
        formatter.dateFormat = format
        let text = formatter.string(from: date)
        return text
    }
}
