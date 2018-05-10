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
//        _interactor.fetchMedia(for: "iN utERo", page: 1)
    }
}

// MARK: - Extensions -




// MARK: - Actions from UI
extension SearchPresenter: SearchPresenterInterface {
    func startSearch(searchTerm: String) {
        currentPage = 1
        
        currentMedias = []
        _view.medias = []
        
        lastTerm = searchTerm
        
        _view.showLoadingIndicator()
        _interactor.fetchMedia(for: searchTerm, page: 1)
    }
    
    func nextPage(searchTerm: String) {
        guard searchTerm == lastTerm else {
            startSearch(searchTerm: searchTerm)
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
        // Se ignorará medias cuyo "collectionId" es nil, ya que no se puede obtener detalles de álbum sin él
        // Por algún motivo llegan trailer de películas aunque específicamente se pidió "song", así que se eliminará esos resultados indeseados
        // Ejemplo: Buscar "sandman" y verificar "kind" de Spiderman: Homecoming
        
        let filtered = medias.filter { $0.collectionId != nil && $0.kind != nil && $0.kind! == "song" }
        currentMedias.append(contentsOf: filtered)
        
        _view.medias = currentMedias
        _view.hideLoadingIndicator()
        
        showNoResultsIfNeeded()
        
        // Guardar resultados obtenidos en core data para recuperarlos sin conexión
        saveResults(for: lastTerm, medias: currentMedias)
    }
    
    func failureFetching(error: Error?) {
        guard let error = error else {
            print("ERROR: No se pudo obtener la información.")
            return
        }
        
        print("ERROR: \(error)")
        
        let cachedMedias = _interactor.fetchLocalResults(for: lastTerm)
        
        _view.hideLoadingIndicator()
        
        if cachedMedias.count == 0 {
            showNoResultsIfNeeded()
        } else {
            _view.medias = cachedMedias
            _view.hideLoadingIndicator()
        }
    }
    
    private func showNoResultsIfNeeded() {
        if currentMedias.count == 0 {
            _view.showNoResultsMessage()
        } else {
            _view.hideNoResultsMessage()
        }
    }
}




// MARK: - Core data
extension SearchPresenter {
    fileprivate func saveResults(for term: String, medias: [Media]) {
        do {
            let jsonData = try JSONEncoder().encode(medias)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                _interactor.saveLocalResults(for: term, json: jsonString)
            }
        } catch {
            print("[COREDATA] ERROR: \(error.localizedDescription)")
        }
    }
}
