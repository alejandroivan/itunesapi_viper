import UIKit
import AlamofireImage

final class DetailsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Private properties -
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    
    
    // MARK: - Public properties -
    var presenter: DetailsPresenterInterface!
    var searchItem: Media?
    
    var album: Media? {
        didSet {
            // Artwork
            coverImageView.af_cancelImageRequest()
            coverImageView.image = nil
            
            if let artwork = album?.urlForArtwork {
                coverImageView.af_setImage(withURL: artwork)
            }
            
            // Labels
            artistLabel.text = album?.artistName
            albumLabel.text = album?.collectionName
            
            // Título del view controller
            title = album?.collectionName
        }
    }
    
    var tracks: [Media]? = nil {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        // Sacar placeholders que vienen desde el storyboard
        artistLabel.text = nil
        albumLabel.text = nil
        
        tableView.delegate = self
        tableView.dataSource = self
    }
	
}

// MARK: - Extensions -

extension DetailsViewController: DetailsViewInterface {
}





// MARK: - UITableView
extension DetailsViewController: UITableViewDataSource {
    static let cellIdentifier = "DetailsTableViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tracks = tracks else {
            return 0
        }
        
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsViewController.cellIdentifier, for: indexPath) as! DetailsTableViewCell
        let item = tracks?[indexPath.row]
        
        cell.trackTitle = item?.trackName
        cell.trackNumber = item?.trackNumber
        
        return cell
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let track = tracks?[indexPath.row] else {
            return
        }
        
        print("Playing: \(track)")
    }
}
