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
