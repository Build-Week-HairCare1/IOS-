//
//  StylistDetailViewController.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 07/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class StylistDetailViewController: UIViewController {
    
    @IBOutlet weak var stylistImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var stylistName: UILabel!
    @IBOutlet weak var stylistBio: UITextView!
    
    var stylist: StylistRepresentation? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard let stylist = stylist else { return }
        
        stylistImage.image = UIImage(named: stylist.photo)
        locationLabel.text = "Based in \(stylist.city)"
        stylistName.text = "\(stylist.firstName) \(stylist.lastName)"
        stylistBio.text = stylist.bio
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
