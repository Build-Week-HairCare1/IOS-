//
//  SignInViewController.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 03/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var apiController: APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        guard let _ = apiController,
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
            
        let customer = SignInUser(email: email, password: password)
        
        signIn(customer: customer)
    }
    
    func signIn(customer: SignInUser) {
        apiController?.signIn(customer: customer, completion: { (error) in
            if let error = error {
                NSLog("Error occured during sign in: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })
    }
    
    func updateViews() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
    }
}
