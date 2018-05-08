import Foundation

struct Media: Decodable {
    let wrapperType: String
    let kind: String
    
    let trackId: Int
    let trackName: String
    let artistName: String
    let collectionName: String
    
    var artwork: String?
    var urlForArtwork: URL? {
        guard let artwork = artwork else {
            return nil
        }
        
        return URL(string: artwork)
    }

    var previewUrl: String?
    var urlForPreview: URL? {
        guard let previewUrl = previewUrl else {
            return nil
        }
        
        return URL(string: previewUrl)
    }
}




extension Media {
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind, trackName, artistName, collectionName, artwork, previewUrl, trackId
    }
}
