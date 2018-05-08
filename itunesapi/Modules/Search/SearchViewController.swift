import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: SearchPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
}

// MARK: - Extensions -

extension SearchViewController: SearchViewInterface {
}
