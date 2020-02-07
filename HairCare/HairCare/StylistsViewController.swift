//
//  StylistsViewController.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 06/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class StylistsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var allStylistsCollectionView: UICollectionView!
    
    let apiController = APIController()
    var stylists: [StylistRepresentation] = []
    var stylistsByCity: [StylistRepresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        allStylistsCollectionView.dataSource = self
        allStylistsCollectionView.dataSource = self
        
        apiController.fetchAllStylists { (result) in
            do {
                let stylists = try result.get()
                DispatchQueue.main.async {
                    self.stylists = stylists
                }
            } catch {
                if let error = error as? NetworkError {
                    NSLog("Error fetching stylists: \(error)")
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if apiController.bearer == nil {
            performSegue(withIdentifier: "SignInShowSegue", sender: self)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stylists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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
