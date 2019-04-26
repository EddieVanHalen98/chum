//
//  Ext+Number.swift
//  chum
//
//  Created by James Saeed on 26/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import Foundation

extension Double {
	/// Rounds the double to decimal places value
	func rounded(toPlaces places:Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
