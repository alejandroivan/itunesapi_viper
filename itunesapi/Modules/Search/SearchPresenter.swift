import UIKit

final class SearchPresenter {

    // MARK: - Private properties -

    private unowned var _view: SearchViewInterface
    private var _interactor: SearchInteractorInterface
    private var _wireframe: SearchWireframeInterface

    // MARK: - Lifecycle -

    init(wireframe: SearchWireframeInterface, view: SearchViewInterface, interactor: SearchInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

// MARK: - Extensions -

extension SearchPresenter: SearchPresenterInterface {
}
