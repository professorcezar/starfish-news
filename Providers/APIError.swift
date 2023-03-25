enum APIError: Error {
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
}
