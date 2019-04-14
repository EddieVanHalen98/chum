//
//  MatchCell.swift
//  chum
//
//  Created by James Saeed on 06/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit
import Kingfisher

class MatchCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func build(for match: Match) {
        ratingLabel.text = "\(match.rating)"
        profileImage.kf.setImage(with: match.user.imageURL)
    }
}
