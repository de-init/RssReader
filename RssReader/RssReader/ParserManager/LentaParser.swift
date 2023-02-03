import UIKit

final class LentaParser: NSObject {
    var xmlParser: XMLParser?
    var feeds: [Feed] = []
    var xmlText = ""
    var currentFeed: Feed?
    
    func parse(url: URL) -> [Feed] {
        xmlParser = XMLParser(contentsOf: url)
        xmlParser?.delegate = self
        xmlParser?.parse()
        return feeds
    }
}

extension LentaParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        xmlText = ""
        if elementName == "item" {
            currentFeed = Feed()
        } else if (elementName as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                currentFeed?.image = urlString
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == FeedBlockName.author.rawValue {
            currentFeed?.author = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if elementName == FeedBlockName.title.rawValue {
            currentFeed?.title = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if elementName == FeedBlockName.description.rawValue {
            currentFeed?.description = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if elementName == FeedBlockName.pubDate.rawValue {
            let text = xmlText.trimmingCharacters(in: .whitespacesAndNewlines).formated(from: "E, dd MMM yyyy HH:mm:ss Z", to: "hh:mm dd.MM.YYYY")
            currentFeed?.date = text
        }
        if elementName == "item" {
            if let feed = currentFeed {
                feeds.append(feed)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
          xmlText += string
    }
}
