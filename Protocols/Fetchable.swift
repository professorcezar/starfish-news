import Combine

protocol Fetchable {
    func fetchArticles() -> AnyPublisher<[Article], APIError>
    func fetchArticles(completionHandler: @escaping (Result<[Article], APIError>) -> Void)
}
