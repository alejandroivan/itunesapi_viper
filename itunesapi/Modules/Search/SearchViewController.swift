import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Public properties -
    @IBOutlet weak var tableView: UITableView!

    var presenter: SearchPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
	
    var medias: [Media] = [] {
        didSet {
            tableView.reloadData()
        }
    }
}

// MARK: - Extensions -

extension SearchViewController: SearchViewInterface {
}




// MARK: - UITableView
extension SearchViewController: UITableViewDataSource {
    static let contentCellIdentifier = "SearchTableViewCell"
    static let emptyCellIdentifier = "SearchEmptyTableViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard medias.count != 0 else {
            return 1
        }
        
        return medias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = medias.count != 0 ? SearchViewController.contentCellIdentifier : SearchViewController.emptyCellIdentifier
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if cellIdentifier == SearchViewController.contentCellIdentifier {
            let contentCell = cell as! SearchTableViewCell
            let media = medias[indexPath.row]
            
            contentCell.media = media
        }
        
        return cell
    }
}




extension SearchViewController: UITableViewDelegate {
    
}
