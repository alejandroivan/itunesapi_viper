import UIKit

final class DetailsWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let _storyboard = UIStoryboard(name: "Details", bundle: nil)

    // MARK: - Module setup -

    init(media: Media) {
        let moduleViewController = _storyboard.instantiateViewController(ofType: DetailsViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter(wireframe: self, view: moduleViewController, interactor: interactor, item: media)
        interactor.presenter = presenter
        moduleViewController.presenter = presenter
        
        print("Details for: \(media)")
    }

}

// MARK: - Extensions -

extension DetailsWireframe: DetailsWireframeInterface {

    func navigate(to option: DetailsNavigationOption) {
    }
}
