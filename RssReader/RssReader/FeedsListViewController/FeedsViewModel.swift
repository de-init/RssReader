import UIKit

class FeedsViewModel {
    
    private let parser = LentaParser()
    
    func fetchData(with url: URL) -> [Feed]{
        let data = parser.parse(url: url)
        return data
    }
}
