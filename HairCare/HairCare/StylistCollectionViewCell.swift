//
//  StylistCollectionViewCell.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 06/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class StylistCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stylistImage: UIImageView!
    @IBOutlet weak var stylistName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    var stylist: StylistRepresentation? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let stylist = stylist else { return }
        
        stylistImage.image = UIImage(named: stylist.photo)
        stylistName.text = "\(stylist.firstName) \(stylist.lastName)"
        location.text = "\(stylist.city), \(stylist.state)"
        
        switch stylist.reviews.stars {
        case 1:
            rating.text = "★☆☆☆☆"
        case 2:
            rating.text = "★★☆☆☆"
        case 3:
            rating.text = "★★★☆☆"
        case 4:
            rating.text = "★★★★☆"
        case 5:
            rating.text = "★★★★★"
        default:
            rating.text = "\(rating)"
        }
    }
}
