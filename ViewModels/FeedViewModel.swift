import Foundation
import Combine
import os.log

enum FeedViewModelState {
    case idle
    case loading
    case success(articles: [Article])
    case failure(error: Error)
}

enum FeedViewModelEvent {
    case refresh
}

final class FeedViewModel: ObservableObject {
    @Published var state: FeedViewModelState = .idle
    private let provider = NewsProvider()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.invoke(.refresh)
    }
    
    func invoke(_ event: FeedViewModelEvent) {
        fetchArticles()
    }
    
    private func fetchArticles() {
        state = .loading
        provider.fetchArticles()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.state = .failure(error: error)
                case .finished:
                    break
                }
            } receiveValue: { articles in
                self.state = .success(articles: articles)
            }
            .store(in: &cancellables)
    }
}
