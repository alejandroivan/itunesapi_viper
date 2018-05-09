import Foundation

struct Media: Codable {
    let wrapperType: String
    let artistName: String
    
    let collectionId: Int?
    let collectionName: String?

    let kind: String?
    let trackId: Int?
    let trackName: String?
    let trackNumber: Int?

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
        case wrapperType, kind, trackName, trackNumber, artistName, collectionId, collectionName, previewUrl, trackId
        case artwork = "artworkUrl100"
    }
}
