import UIKit

class LentaParser: NSObject {
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
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "author" {
            currentFeed?.author = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if elementName == "title" {
            currentFeed?.title = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if elementName == "description" {
            currentFeed?.description = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if elementName == "pubDate" {
            currentFeed?.date = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
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
