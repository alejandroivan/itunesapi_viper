import Foundation

struct Constants {
    struct API {
        static let searchURL = URL(string: "https://itunes.apple.com/search?mediaType=music&limit=20")!
        static let resultsPerPage = 20
        
        static let detailsURL = URL(string: "https://itunes.apple.com/lookup?entity=song")! // &id=collectionId
    }
}
