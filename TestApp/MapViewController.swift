//
//  MapViewController.swift
//  
//
//  Created by admin on 01.07.17.
//
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate  {
    
    
    
   
    
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    var solebox = ShopPunkt()

    
    @IBOutlet weak var pinAlert: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        self.map.delegate = self
        map.showsUserLocation = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
       
        let currentLocation = userLocation.location?.coordinate
        
        self.map.region = MKCoordinateRegionMakeWithDistance(currentLocation!, 1000, 1000)
        self.solebox.coordinate = CLLocationCoordinate2DMake(52.50, 13.33)
        let location = userLocation.location
        let locationSolebox = CLLocation(latitude:52.50 , longitude: 13.33)
        
        
        let distance = location?.distance(from: locationSolebox)
        let distanceasdouble = 0.5 + distance!
        
        
        if (distanceasdouble < 1000){
            
            alertUser()
            Session.distance = true
            
        }
        
        else {
          Session.distance = false
        pinAlert.isHidden = true
            
        }
        
        self.solebox.title = "Solebox"
        self.solebox.subtitle = "The most famous Sneakershop in Berlin"
        map.addAnnotation(solebox)
        
        
    }
    
    func alertUser() {
        
        pinAlert.isHidden = false
        
    
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if ((!(annotation is ShopPunkt)) || ((annotation as! ShopPunkt).nameDerShop != "Sneakerladen"))
        {
            
            return nil
        }
        
        let reuseId = "Sneakerladen"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        annotationView?.rightCalloutAccessoryView = UIButton.init(type: UIButtonType.detailDisclosure)

        if annotationView == nil {
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            let rightButton = UIButton(type: .contactAdd)
            rightButton.tag = annotation.hash
            rightButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = rightButton
            
            
            
        }
        
        else {
            
            
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }

    
    func buttonClicked(){
        
        self.performSegue(withIdentifier: "showSolebox", sender: self)
        
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
