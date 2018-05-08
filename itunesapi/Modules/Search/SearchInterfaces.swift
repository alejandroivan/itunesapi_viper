import UIKit

enum SearchNavigationOption {
}

protocol SearchWireframeInterface: WireframeInterface {
    func navigate(to option: SearchNavigationOption)
}

protocol SearchViewInterface: ViewInterface {
    var medias: [Media] { get set }
}

protocol SearchPresenterInterface: PresenterInterface {
    func nextPage(searchTerm: String)
    func successFetching(medias: [Media])
    func failureFetching(error: Error?)
}

protocol SearchInteractorInterface: InteractorInterface {
    func fetchMedia(for term: String, page: Int)
}
