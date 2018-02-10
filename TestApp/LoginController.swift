//
//  LoginController.swift
//  TestApp
//
//  Created by admin on 12.07.17.
//  Copyright © 2017 s65229. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    
    
    
    @IBAction func login(_ sender: Any) {
        errorLabel.isHidden = true
        let passwd = DatabaseManagement.shared.findProduct(inputEmail: emailField.text!)
        if (passwd != ""){
            
            print("i know you")
            print("your password is" + passwd)
            
            if (passwd == passwordField.text!){
            print("You are logged in")
                Session.email=emailField.text!
                self.performSegue(withIdentifier: "logged", sender: self)

                
            }
            else {
            errorLabel.text = "Password invalid!"
            errorLabel.isHidden = false
            }
            
            
        }
        

    
    else {
    errorLabel.text = "Register first!"
            errorLabel.isHidden = false
    print("who da fack are you")
    }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true

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
