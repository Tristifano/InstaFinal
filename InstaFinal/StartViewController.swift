//
//  StartViewController.swift
//  InstaFinal
//
//  Created by MacBook on 2/26/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import TextFieldEffects
import FirebaseAuth

class StartViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons(enabled: false)
        loginButton.backgroundColor = UIColor.darkGray
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.clipsToBounds = true
        signUpButton.backgroundColor = UIColor.darkGray
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.clipsToBounds = true
        emailTextField.delegate = self
        passWordTextField.delegate = self
        emailTextField.addTarget( self, action: #selector(textFieldChanged), for: .editingChanged)
        passWordTextField.addTarget( self, action: #selector(textFieldChanged), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passWordTextField: HoshiTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    func setButtons(enabled: Bool) {
        if enabled {
            loginButton.alpha = 1.0
            signUpButton.alpha = 1.0
            loginButton.isEnabled = true
            signUpButton.isEnabled = true
        } else {
            loginButton.alpha = 0.5
            signUpButton.alpha = 0.5
            loginButton.isEnabled = false
            signUpButton.isEnabled = false
        }
    }
    
    @objc func textFieldChanged(_ target: HoshiTextField) {
        let email = emailTextField.text
        let password = passWordTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setButtons(enabled: formFilled)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
            passWordTextField.becomeFirstResponder()
        case passWordTextField:
            passWordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passWordTextField.text else { return }
        
        setButtons(enabled: false)
        
        Auth.auth().signIn(withEmail: email, password: password) {user, error in
            if error == nil && user !=  nil {
                self.loginSuccess()
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                self.loginFailed(error: error!)
                self.resetButtons()
            }
        }
    }
 
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passWordTextField.text else { return }
        
        setButtons(enabled: false)
        
        Auth.auth().createUser(withEmail: email, password: password) {user, error in
            if error == nil && user !=  nil {
                self.dismiss(animated: false, completion: nil)
                self.signUpSuccess()
            } else {
                print("Error Creating Account: \(error!.localizedDescription)")
                self.signUpFailed(error: error!)
                self.resetButtons()
            }
        }
    }
    func loginSuccess() {
        let alert = UIAlertController(title: "Login Success" , message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    func loginFailed(error: Error) {
        let alert = UIAlertController(title: "Login Failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    func signUpSuccess(){
        let alert = UIAlertController(title: "User Created", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    func signUpFailed(error: Error) {
        let alert = UIAlertController(title: "User Creation Failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    func resetButtons() {
        let alert = UIAlertController(title: "Error Logging In.\n Please Try Again.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
                
        setButtons(enabled: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
