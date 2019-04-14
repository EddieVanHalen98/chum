//
//  FirstViewController.swift
//  chum
//
//  Created by James Saeed on 31/03/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class MatchesViewController: UICollectionViewController, Storyboarded {
    
    weak var coordinator: MatchesCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchCell", for: indexPath) as? MatchCell else { return UICollectionViewCell() }
        
        let user = User(uid: "123456", name: "James Saeed", imageURL: URL(string: "http://jtsaeed.com/images/avatar.jpg")!)
        cell.build(for: Match(rating: 8.6, user: user))
        
        return cell
    }
}
