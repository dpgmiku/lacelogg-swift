//
//  SoleboxViewController.swift
//  TestApp
//
//  Created by admin on 13.07.17.
//  Copyright © 2017 s65229. All rights reserved.
//

import UIKit

class SoleboxViewController: UIViewController {
    var thisAsortiment: Asortiment?
    var zaehler = 0
    var buttonZaehler = 0
    var anzahlZaehler = 1000000
    var anzahlno = 99999
    public var angemeldet: [Int: Bool] = [0:false,1:false]
    
    
   

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for asortiment in DatabaseManagement.shared.findAsortimentOfShop(inputShop: "solebox")
            {
                var imageView: UIImageView
                anzahlno = asortiment.anzahl

                imageView = UIImageView(frame:CGRect(x:10, y:300+zaehler, width:100, height:100))
                imageView.image = UIImage(named:asortiment.image)
                let label = UILabel(frame: CGRect(x: 180, y: 305+zaehler, width: 200, height: 21))
                
                let anzahl = UILabel(frame: CGRect(x: 120, y: 350+zaehler, width: 200, height: 21))
                    anzahl.tag = anzahlZaehler
                let button:UIButton = UIButton(frame: CGRect(x: 230, y: 340+zaehler, width: 100, height: 40))
                button.tag = buttonZaehler
              thisAsortiment = asortiment
                
                if (asortiment.anzahl != 0){
                    button.isUserInteractionEnabled = true
                    if (!(DatabaseManagement.shared.findAngemeldet(inputUsername: Session.email!, inputShop: asortiment.shop, inputShoe: asortiment.nameShoe))){
                        
                        if (!(Session.distance!)){
                            button.backgroundColor = .black
                            button.setTitle("Too far", for: .normal)
                            button.isUserInteractionEnabled = false
                            
                        }
                        else
                        {
                        
                button.backgroundColor = .yellow
                button.setTitle("Anmelden", for: .normal)
                            button.isUserInteractionEnabled = true


                    }
                    }
                    else {
                        button.backgroundColor = .green
                        
                        button.setTitle("Angemeldet", for: .normal)
                        
                        
                    }
                    
                    
                }
                else {
                    if (DatabaseManagement.shared.findAngemeldet(inputUsername: Session.email!, inputShop: asortiment.shop, inputShoe: asortiment.nameShoe)){
                        
                        button.backgroundColor = .green
                        button.isUserInteractionEnabled = true
                        button.setTitle("Angemeldet", for: .normal)

                    }
                    else{
                    
                        
                button.backgroundColor = .black
                button.setTitle("Anzahl: 0", for: .normal)
                button.isUserInteractionEnabled = false
                    
                }
                
                }
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                self.view.addSubview(button)

               
                
               
                


                label.text = asortiment.nameShoe
                anzahl.text = "Anzahl: " + asortiment.anzahl.description
                anzahlno = asortiment.anzahl
                self.view.addSubview(imageView)
                self.view.addSubview(label)
                self.view.addSubview(anzahl)
                zaehler = zaehler+120
                buttonZaehler = buttonZaehler + 1
                anzahlZaehler = anzahlZaehler + 1
                }
       
        

        // Do any additional setup after loading the view.
    
    
    }
            
    
        
    func buttonAction(sender:UIButton!) {
        print("Button Clicked")
        var name = ""
        if (sender.tag == 0){
            name = "yeezy 350 Beluga"
        }
        if (sender.tag == 1){
            
            name = "Saucony Burger"
        }
       _ = DatabaseManagement.shared.addAngemeldet(inputShop: "solebox", inputUsername: Session.email!, inputShoe: name, inputAngemeldet: false )
        if (!(DatabaseManagement.shared.findAngemeldet(inputUsername: Session.email!, inputShop: "solebox", inputShoe: name))){
        _ = DatabaseManagement.shared.updateAnzahl(shoeNameGive: name, PlusOderMinus: "-")
            
                let theLabel = self.view.viewWithTag(sender.tag + 1000000) as? UILabel
             anzahlno = anzahlno - 1
                theLabel?.text = "Anzahl: " + DatabaseManagement.shared.findAnzahl(shoeNameGive: name, shopNamevar: "solebox").description
            
            sender.backgroundColor = .green

            sender.setTitle("Angemeldet", for: .normal)
        }
        else {
            _ = DatabaseManagement.shared.updateAnzahl(shoeNameGive: name, PlusOderMinus: "+")
            let theLabel = self.view.viewWithTag(sender.tag + 1000000) as? UILabel
            anzahlno = anzahlno + 1
 theLabel?.text = "Anzahl: " + DatabaseManagement.shared.findAnzahl(shoeNameGive: name, shopNamevar: "solebox").description            
            
            if (!(Session.distance!)){
                sender.backgroundColor = .black
                sender.setTitle("Too far", for: .normal)
                sender.isUserInteractionEnabled = false
                
            }
            else
            {
            

            sender.backgroundColor = .yellow
            angemeldet[sender.tag] = false
            sender.setTitle("Anmelden", for: .normal)
                sender.isUserInteractionEnabled = true

            }

        }
       _ =  DatabaseManagement.shared.updateAngemeldet(shop: "solebox", user: Session.email!, shoe: name)
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
