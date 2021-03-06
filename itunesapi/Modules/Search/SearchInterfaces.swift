import UIKit

enum SearchNavigationOption {
    case details(Media)
}

protocol SearchWireframeInterface: WireframeInterface {
    func navigate(to option: SearchNavigationOption)
}

protocol SearchViewInterface: ViewInterface {
    var medias: [Media] { get set }
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNoResultsMessage()
    func hideNoResultsMessage()
}

protocol SearchPresenterInterface: PresenterInterface {
    func startSearch(searchTerm: String)
    func nextPage(searchTerm: String)
    
    func successFetching(medias: [Media])
    func failureFetching(error: Error?)
    
    func didSelect(media: Media)
}

protocol SearchInteractorInterface: InteractorInterface {
    func fetchMedia(for term: String, page: Int)
    
    func saveLocalResults(for query: String, json: String)
    func fetchLocalResults(for query: String) -> [Media]
}
