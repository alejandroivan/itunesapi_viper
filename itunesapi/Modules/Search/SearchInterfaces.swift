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
}
