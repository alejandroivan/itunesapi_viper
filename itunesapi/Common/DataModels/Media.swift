import Foundation

struct Media: Decodable {
    let wrapperType: String
    let artistName: String
    let collectionName: String?

    let kind: String?
    let trackId: Int?
    let trackName: String?

    var artwork: String?
    var previewUrl: String?
}




extension Media {
    var urlForArtwork: URL? {
        guard let artwork = artwork else {
            return nil
        }
        
        return URL(string: artwork)
    }
    
    var urlForPreview: URL? {
        guard let previewUrl = previewUrl else {
            return nil
        }
        
        return URL(string: previewUrl)
    }
}




extension Media {
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind, trackName, artistName, collectionName, previewUrl, trackId
        case artwork = "artworkUrl100"
    }
}
