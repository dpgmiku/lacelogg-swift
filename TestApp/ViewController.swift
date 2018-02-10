//
//  ViewController.swift
//  TestApp
//
//  Created by admin on 18.06.17.
//  Copyright © 2017 s65229. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var myScrollView: UIScrollView!
    var imageArray = [UIImage]()

   
    override func viewDidLoad() {
             super.viewDidLoad()
               let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        
        let newCenter = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height-50)
        loginButton.center = newCenter
        
        view.addSubview(loginButton)
        
        myScrollView.frame = view.frame
        imageArray = [#imageLiteral(resourceName: "a-detailed-look-at-end-saucony-burger-1"), #imageLiteral(resourceName: "Yeezy-Boost-350-V2-Grey-Orange-on-foot-7"), #imageLiteral(resourceName: "Nike_Air_Yeezy_II_Profile_original")]
        
        for i in 0..<imageArray.count {
            
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.myScrollView.frame.width, height: self.myScrollView.frame.height)
            
            myScrollView.contentSize.width = myScrollView.frame.width * CGFloat(i+1)
            myScrollView.addSubview(imageView)
            
        }

        // Do any additional setup after loading the view, typically from a nib.
            
        
     //   _ = DatabaseManagement.shared.addAsortiment(inputShop: "solebox", inputNameShoe: "yeezy 350 Beluga", inputImage: "Yeezy-Boost-350-V2-Grey-Orange-on-foot-7.png", inputAnzahl: 5)
        DatabaseManagement.shared.queryAllAsortiments()
    
    }
   
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            
            print("error")
            return
        }
        
        print("sucessfully logged in with facebook®")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

