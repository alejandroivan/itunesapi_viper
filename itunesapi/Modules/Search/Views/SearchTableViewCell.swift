//
//  SearchTableViewCell.swift
//  itunesapi
//
//  Created by dpsmac1 on 08-05-18.
//  Copyright © 2018 Alejandro Iván. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak private var cellImageView: UIImageView!
    @IBOutlet weak private var cellTrackLabel: UILabel!
    @IBOutlet weak private var cellArtistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var media: Media? = nil {
        didSet {
            cellImageView.af_cancelImageRequest()
            
            guard let media = media else {
                cellImageView.image = nil
                cellTrackLabel.text = "Error al obtener información"
                cellArtistLabel.text = nil
                return
            }
            
            cellImageView.image = nil
            
            if let artworkUrl = media.urlForArtwork {
                cellImageView.af_setImage(withURL: artworkUrl)
            }
            
            cellTrackLabel.text = media.trackName
            cellArtistLabel.text = media.artistName
        }
    }
}
