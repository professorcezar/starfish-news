import Foundation

struct NewsResponseModel: Codable { // https://newsdata.io/
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let content: String
    let url: String?
    let publishedAt: String
    let urlToImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case content
        case url
        case publishedAt
        case urlToImage
    }
    
    var imageURL: URL? {
        guard let urlToImage else { return nil }
        return URL(string: urlToImage)
    }
    
    var articleURL: URL? {
        guard let url else { return nil }
        return URL(string: url)
    }
    
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: publishedAt)
    }
}
