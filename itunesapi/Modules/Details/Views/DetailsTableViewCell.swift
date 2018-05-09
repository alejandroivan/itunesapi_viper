//
//  DetailsTableViewCell.swift
//  itunesapi
//
//  Created by Alejandro Melo Domínguez on 08-05-18.
//  Copyright © 2018 Alejandro Iván. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet private weak var trackNumberLabel: UILabel!
    @IBOutlet private weak var trackTitleLabel: UILabel!
    
    var trackNumber: Int? {
        didSet {
            guard let number = trackNumber else {
                trackNumberLabel.text = "00"
                return
            }
            
            var numberStr = String(number)
            if numberStr.count == 1 {
                numberStr = "0" + numberStr
            }
            
            trackNumberLabel.text = numberStr
        }
    }
    
    var trackTitle: String? {
        didSet {
            trackTitleLabel.text = trackTitle ?? "No se pudo obtener el título de esta canción."
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
