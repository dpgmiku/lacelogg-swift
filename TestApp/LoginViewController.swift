//
//  LoginViewController.swift
//  TestApp
//
//  Created by admin on 30.06.17.
//  Copyright © 2017 s65229. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var errorLab: UILabel!

    
    @IBOutlet weak var nameField: UITextField!
    
    
    @IBOutlet weak var vornameField: UITextField!
    
    @IBOutlet weak var handynrField: UITextField!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func registrieren(_ sender: Any) {
        let nameFieldbool = (nameField.text?.isEmpty)!
        let vornameFieldbool = (vornameField.text?.isEmpty)!
        let handynrFieldbool = (handynrField.text?.isEmpty)!
        let emailFieldbool = (emailField.text?.isEmpty)!
        nameField.backgroundColor = .white
        vornameField.backgroundColor = .white
        handynrField.backgroundColor = .white
        emailField.backgroundColor = .white
        errorLab.isHidden = true
        

        if ( !(nameFieldbool || vornameFieldbool || handynrFieldbool || emailFieldbool)) {
            let id = DatabaseManagement.shared.addProduct(inputName: nameField.text!, inputVorname: vornameField.text!, inputEmail: emailField.text!, inputPassword: handynrField.text!)
            if (id == nil) {
                errorLab.isHidden = false
                
            print("we have already a user with this email address in our database")
            }
            else {
                Session.email = emailField.text!
                
            
            print("succesfully added, id: \(String(describing: id))")
            self.performSegue(withIdentifier: "meinSegue", sender: self)
            }
        }
        
            
            
        
        else {
            if (nameFieldbool)
            {
                nameField.backgroundColor = .red
                
            }
            if (vornameFieldbool)
            {
                vornameField.backgroundColor = .red
                
            }

            if (handynrFieldbool)
            {
                handynrField.backgroundColor = .red
                
            }
            if (emailFieldbool && !(validateEmail(candidate: emailField.text!)))
            {
                emailField.backgroundColor = .red
                
            }

            
            
        }
        

        
        
        
    }
    
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLab.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
