import Foundation
import Alamofire

final class SearchInteractor {
    weak var presenter: SearchPresenter!
}

// MARK: - Extensions -

extension SearchInteractor: SearchInteractorInterface {
    func fetchMedia(for term: String, page: Int) {
        let queryURL = searchURL(for: term, page: page)
        
        ApiClient.get(queryURL.absoluteString, success: { response in
            do {
                let searchNode = try JSONDecoder().decode(SearchNode.self, from: response)
                self.presenter.successFetching(medias: searchNode.results)
            } catch {
                self.presenter.failureFetching(error: error)
            }
        }) { error in
            self.presenter.failureFetching(error: error)
        }
        
    }
}




// MARK: - Search URL
extension SearchInteractor {
    func searchURL(for term: String, page: Int = 1) -> URL {
        var urlComponents = URLComponents(url: Constants.API.searchURL, resolvingAgainstBaseURL: true)!

        guard var queryItems = urlComponents.queryItems else {
            let termItem = URLQueryItem(name: "term", value: term)
            let pageItem = URLQueryItem(name: "offset", value: String((page - 1) * Constants.API.resultsPerPage))
            
            urlComponents.queryItems = [termItem, pageItem]
            return urlComponents.url!
        }
        
        let termItem = URLQueryItem(name: "term", value: term)
        let pageItem = URLQueryItem(name: "offset", value: String((page - 1) * Constants.API.resultsPerPage))

        queryItems.append(contentsOf: [termItem, pageItem])
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
}




// MARK: - Response Models (Encodable)
extension SearchInteractor {
    struct SearchNode: Decodable {
        enum CodingKeys: String, CodingKey { case results }
        let results: [Media]
    }
}
