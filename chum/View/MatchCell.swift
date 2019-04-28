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
        ratingLabel.text = match.rating
		setRatingColor(for: match)
		
        profileImage.kf.setImage(with: match.matchedUser.imageURL)
    }
	
	func setRatingColor(for match: Match) {
		if let rating = Double(match.rating) {
			if rating >= 9.0 {
				ratingLabel.textColor = UIColor(named: "match9")
			} else if rating < 9.0 && rating >= 8.0 {
				ratingLabel.textColor = UIColor(named: "match8")
			} else if rating < 8.0 && rating >= 7.0 {
				ratingLabel.textColor = UIColor(named: "match7")
			} else if rating < 7.0 && rating >= 6.0 {
				ratingLabel.textColor = UIColor(named: "match6")
			} else if rating < 6.0 && rating >= 5.0 {
				ratingLabel.textColor = UIColor(named: "match5")
			} else if rating < 5.0 && rating >= 4.0 {
				ratingLabel.textColor = UIColor(named: "match4")
			} else if rating < 4.0 && rating >= 3.0 {
				ratingLabel.textColor = UIColor(named: "match3")
			} else {
				ratingLabel.textColor = UIColor(named: "match2")
			}
		}
	}
}
