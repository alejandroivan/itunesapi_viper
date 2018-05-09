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
    }

}

// MARK: - Extensions -

extension DetailsWireframe: DetailsWireframeInterface {

    func navigate(to option: DetailsNavigationOption) {
        switch option {
        case .goBack:
            navigationController?.popViewController(animated: true)
            
        case .preview(let song):
            showPlayer(song: song)
        }
    }
    
    func showPlayer(song: Media) {
        let player = PreviewPlayerWireframe(song: song)
        viewController.presentWireframe(player)
    }
}
