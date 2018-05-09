import UIKit

final class DetailsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public properties -
    var presenter: DetailsPresenterInterface!
    var searchItem: Media?

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
//        tableView.delegate = self
//        tableView.dataSource = self
    }
	
}

// MARK: - Extensions -

extension DetailsViewController: DetailsViewInterface {
}





//// MARK: - UITableView
//extension DetailsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//
//}
//
//extension DetailsViewController: UITableViewDelegate {
//
//}
