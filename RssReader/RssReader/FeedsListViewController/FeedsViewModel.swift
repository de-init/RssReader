import UIKit
import RealmSwift

class FeedsViewModel {
    
    private let parser = LentaParser()
    
    func fetchData(with url: URL) -> [Feed]{
        let data = parser.parse(url: url)
        return data
    }
    
    func saveData(model: [Feed]) -> [FeedModel] {
        var feedModel = [FeedModel]()
        
        for i in model {
            let feed = FeedModel(feedTitle: i.title, feedAuthor: i.author, feedDate: i.date, feedDescription: i.description, feedImage: i.image)
            feedModel.append(feed)
        }
        
        let realm = try! Realm()
        try? realm.write {
            realm.add(feedModel)
        }
    
        return feedModel
    }
    
    func loadData() ->  Results<FeedModel> {
        let realm = try! Realm()
        let feedModel = realm.objects(FeedModel.self)
        return feedModel
    }
}
