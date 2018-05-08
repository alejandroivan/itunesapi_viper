import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Public properties -
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    var presenter: SearchPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupSearchController()
    }
	
    var medias: [Media] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let media = medias[indexPath.row]
        presenter.didSelect(media: media)
    }
}




// MARK: - UISearchController
extension SearchViewController {
    func setupSearchController() {
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        let appearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        searchController.searchBar.placeholder = "Nombre de la canción"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .black
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.delegate = self
        
//        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
}




extension SearchViewController: UISearchBarDelegate/*, UISearchResultsUpdating*/ {
//    // Ignoraremos el tipeo, solo buscaremos cuando se presione "intro"
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let term = searchController.searchBar.text?.lowercased() else {
//            return
//        }
//
//        print("Term: \(term)")
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text?.lowercased() else {
            return
        }
        
        presenter.startSearch(searchTerm: term)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        medias = []
    }
}
