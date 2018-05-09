typealias Album = [Media]

extension Sequence where Iterator.Element == Media {
    var albumInfo: Media? {
        var result: Media? = nil
        
        for item in self {
            if item.wrapperType == "collection" {
                result = item
                break
            }
        }
        
        return result
    }
    
    var tracks: [Media] {
        var tracks: [Media] = []
        
        for item in self {
            if item.wrapperType == "track" {
                tracks.append(item)
            }
        }
        
        tracks.sort { $0.trackNumber! < $1.trackNumber! } // Deberían venir ordenadas, pero por si acaso...
        
        return tracks
    }
}
