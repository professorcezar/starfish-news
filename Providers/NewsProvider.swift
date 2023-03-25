import Foundation
import Combine
import os.log

class NewsProvider: Fetchable {
    private var cancellables = Set<AnyCancellable>()
    
    func fetchArticles() -> AnyPublisher<[Article], APIError> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: "f9ad3e2a3aa1474da88b1cbe3533f87e"),
            URLQueryItem(name: "q", value: "iphone")
        ]

        let request = URLRequest(url: components.url!)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: NewsResponseModel.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                } else {
                    return .networkError(error)
                }
            }
            .map { $0.articles }
            .compactMap { $0.filter({ $0.imageURL != nil }) }
            .eraseToAnyPublisher()
    }
    
    func fetchArticles(completionHandler: @escaping (Result<[Article], APIError>) -> Void) {
        fetchArticles()
            .sink { completion in
                switch completion {
                case .finished:
                    Logger.provider.info("Articles successfully fetched")
                case .failure(let error):
                    Logger.provider.error("Error: \(error.localizedDescription)")
                    completionHandler(.failure(error))
                }
            } receiveValue: { articles in
                completionHandler(.success(articles))
            }
            .store(in: &cancellables)
    }
}

