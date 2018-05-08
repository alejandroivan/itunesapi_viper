import UIKit
import ICSPullToRefresh

final class SearchViewController: UIViewController {

    // MARK: - Public properties -
    @IBOutlet weak var tableView: UITableView!
    var presenter: SearchPresenterInterface!
    
    var medias: [Media] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Private properties -
    private var showingNoResults: Bool = false
    lazy private var noResultsLabel: UILabel = {
        let message = UILabel(frame: CGRect(x: tableView.bounds.minX, y: tableView.bounds.minY, width: tableView.bounds.width, height: tableView.bounds.height))
        message.backgroundColor = .white
        message.textColor = .darkGray

        message.text = "No hay resultados."
        message.textAlignment = .center
        
        message.font = UIFont(name: "AvenirNextCondensed", size: 15.0)
        
        return message
    }()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let activityIndicator = UIActivityIndicatorView()
    
    fileprivate var activityIndicatorCount: Int = 0 { // Cuando es 0, se oculta
        didSet {
            if activityIndicatorCount != 0 {
                searchController.searchBar.isUserInteractionEnabled = false
                view.isUserInteractionEnabled = false
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
                view.isUserInteractionEnabled = true
                searchController.searchBar.isUserInteractionEnabled = true
            }
        }
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupActivityIndicator()
        setupInfiniteScrolling()
        setupSearchController()
    }
	
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator.frame = CGRect(x: view.center.x - 30, y: view.center.y - 30, width: 60, height: 60)
        noResultsLabel.frame = CGRect(x: tableView.frame.minX, y: tableView.frame.minY, width: tableView.frame.width, height: tableView.frame.height)
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
        
        hideNoResultsMessage()
        presenter.startSearch(searchTerm: term)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        medias = []
        hideNoResultsMessage()
    }
}




// MARK: - Infinite scrolling (paginación
extension SearchViewController {
    func setupInfiniteScrolling() {
        tableView.addInfiniteScrollingWithHandler {
            guard let term = self.searchController.searchBar.text?.lowercased() else {
                self.medias = []
                return
            }
            
            self.presenter.nextPage(searchTerm: term)
        }
    }
}




// MARK: - Activity indicator
extension SearchViewController {
    func setupActivityIndicator() {
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.clipsToBounds = true
        activityIndicator.layer.cornerRadius = 8.0
        view.addSubview(activityIndicator)
    }
    
    func showLoadingIndicator() {
        activityIndicatorCount += 1
    }
    
    func hideLoadingIndicator() {
        activityIndicatorCount -= 1
    }
}




// MARK: - No results
extension SearchViewController {
    func showNoResultsMessage() {
        if !showingNoResults {
            view.addSubview(noResultsLabel)
            view.bringSubview(toFront: noResultsLabel)
            
            showingNoResults = true
        }
    }
    
    func hideNoResultsMessage() {
        guard showingNoResults else {
            return
        }
        
        showingNoResults = false
        noResultsLabel.removeFromSuperview()
    }
}
