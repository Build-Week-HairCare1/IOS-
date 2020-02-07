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
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var apiController: APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        guard let _ = apiController,
            let fullName = userNameTextField.text,
            let city = cityTextField.text,
            let state = stateTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
            
        let firstName = String(fullName.split(separator: " ")[0])
        let lastName = String(fullName.split(separator: " ").last ?? "")
        
        let customer = SignUpUser(firstName: firstName, lastName: lastName, city: city, state: state, email: email, password: password)
        
        signUp(with: customer)
    }
    
    func signUp(with customer: SignUpUser) {
        apiController?.signUp(customer: customer, completion: { (error) in
            if let error = error {
                NSLog("Error occured during sign up: \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func updateViews() {                
        Utilities.styleTextField(userNameTextField)
        Utilities.styleTextField(cityTextField)
        Utilities.styleTextField(stateTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
}
