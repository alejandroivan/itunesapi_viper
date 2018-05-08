import UIKit

final class SearchPresenter {

    // MARK: - Private properties -

    private unowned var _view: SearchViewInterface
    private var _interactor: SearchInteractorInterface
    private var _wireframe: SearchWireframeInterface
    
    private var lastTerm: String = ""
    private var currentPage: Int = 1
    private var currentMedias: [Media] = []

    // MARK: - Lifecycle -

    init(wireframe: SearchWireframeInterface, view: SearchViewInterface, interactor: SearchInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
    
    func viewDidLoad() {
        _interactor.fetchMedia(for: "iN utERo", page: 1)
    }
}

// MARK: - Extensions -




// MARK: - Actions from UI
extension SearchPresenter: SearchPresenterInterface {
    func nextPage(searchTerm: String) {
        guard searchTerm == lastTerm else {
            currentPage = 1
            
            currentMedias = []
            _view.medias = []
            
            lastTerm = searchTerm
            _interactor.fetchMedia(for: searchTerm, page: 1)
            
            return
        }
        
        currentPage += 1
        lastTerm = searchTerm
        _interactor.fetchMedia(for: searchTerm, page: currentPage)
    }
    
    func didSelect(media: Media) {
        _wireframe.navigate(to: .details(media))
    }
}




// MARK: - Responses from Interactor
extension SearchPresenter {
    func successFetching(medias: [Media]) {
        currentMedias.append(contentsOf: medias)
        _view.medias = medias
    }
    
    func failureFetching(error: Error?) {
        guard let error = error else {
            print("ERROR: No se pudo obtener la información.")
            return
        }
        
        print("Error: \(error)")
    }
}
