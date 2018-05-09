import Foundation
import Alamofire

final class DetailsInteractor {
    weak var presenter: DetailsPresenter!
}

// MARK: - Extensions -

extension DetailsInteractor: DetailsInteractorInterface {
    func fetchAlbumDetails(for item: Media) {
        guard let queryURL = detailsURL(for: item) else {
            self.presenter.failureFetchingAlbum(error: nil)
            return
        }
        
        ApiClient.get(queryURL.absoluteString, success: { response in
            do {
                let searchNode = try JSONDecoder().decode(AlbumNode.self, from: response)
                self.presenter.successFetchingAlbum(album: searchNode.results)
            } catch {
                self.presenter.failureFetchingAlbum(error: error)
            }
        }) { error in
            self.presenter.failureFetchingAlbum(error: error)
        }
    }
}




extension DetailsInteractor {
    func detailsURL(for item: Media) -> URL? {
        guard let collectionId = item.collectionId else {
            return nil
        }
        
        var urlComponents = URLComponents(url: Constants.API.detailsURL, resolvingAgainstBaseURL: true)!
        let queryId = URLQueryItem(name: "id", value: String(collectionId))
        
        guard var queryItems = urlComponents.queryItems else {
            urlComponents.queryItems = [queryId]
            return urlComponents.url!
        }
        
        queryItems.append(queryId)
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
}




// MARK: - Response Models (Encodable)
extension DetailsInteractor {
    struct AlbumNode: Decodable {
        enum CodingKeys: String, CodingKey { case results }
        let results: [Media]
    }
}
