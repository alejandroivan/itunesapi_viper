import UIKit

final class DetailsPresenter {

    // MARK: - Private properties -

    private unowned var _view: DetailsViewInterface
    private var _interactor: DetailsInteractorInterface
    private var _wireframe: DetailsWireframeInterface
    
    var searchItem: Media

    // MARK: - Lifecycle -

    init(wireframe: DetailsWireframeInterface, view: DetailsViewInterface, interactor: DetailsInteractorInterface, item: Media) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        searchItem = item
    }
    
    func viewDidLoad() {
        loadAlbumDetails(item: searchItem)
    }
}

// MARK: - Extensions -

// MARK: Album details
extension DetailsPresenter: DetailsPresenterInterface {
    func loadAlbumDetails(item: Media) {
        _interactor.fetchAlbumDetails(for: item)
    }
    
    func successFetchingAlbum(album: Album) {
        _view.album = album.albumInfo
        _view.tracks = album.tracks
    }
    
    func failureFetchingAlbum(error: Error?) {
        if let error = error {
            print("ERROR: \(String(describing: error))")
        } else {
            print("Error desconocido")
        }
        
        _view.album = nil
        _view.tracks = []
        
        showErrorMessage()
    }
}




// MARK: Previews
extension DetailsPresenter {
    func didSelect(item: Media) {
        guard let _ = item.urlForPreview else {
            return
        }
        
        _wireframe.navigate(to: .preview(item))
    }
}




// MARK: - Error message
extension DetailsPresenter {
    fileprivate func showErrorMessage() {
        let title = "Error al conectar"
        let message = "No se ha podido cargar la información del álbum. Verifica tu conexión a Internet e inténtalo nuevamente."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Volver", style: .cancel, handler: { action in
            self._wireframe.navigate(to: .goBack)
        }))
        
        _view.showAlert(alertController)
    }
}
