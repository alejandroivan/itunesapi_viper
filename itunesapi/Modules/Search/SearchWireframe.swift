import UIKit

final class SearchWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let _storyboard = UIStoryboard(name: "Search", bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = _storyboard.instantiateViewController(ofType: SearchViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension SearchWireframe: SearchWireframeInterface {

    func navigate(to option: SearchNavigationOption) {
    }
}
