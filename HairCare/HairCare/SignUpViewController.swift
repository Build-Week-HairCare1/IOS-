//
//  SignUpViewController.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 03/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    }
    
    func updateViews() {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HairCare")
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        messageLabel.alpha = 0
        
        Utilities.styleTextField(userNameTextField)
        Utilities.styleTextField(locationTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
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
