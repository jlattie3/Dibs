//
//  DibsMapViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 3/31/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import MapKit

class DibsMapViewController: UIViewController {
    
    let GeorgiaTechCoord = CLLocationCoordinate2DMake(33.776575, -84.398287)
    let CulcCoord = CLLocationCoordinate2DMake(33.774621, -84.396367)
    let VanLeerCoord = CLLocationCoordinate2DMake(33.775964, -84.397134)
    let KlausCoord = CLLocationCoordinate2DMake(33.777168, -84.396211)
    let HoweyCoord = CLLocationCoordinate2DMake(33.77744, -84.398678)
    let StudentCenterCoord = CLLocationCoordinate2DMake(33.774149, -84.398818)
    let BoggsCoord = CLLocationCoordinate2DMake(33.775656, -84.399821)
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        mapView.delegate = self
        
        // center initial view at GT Campus
        let regionRadius: CLLocationDistance = 750
        let coordinateRegion = MKCoordinateRegion(center: GeorgiaTechCoord,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.mapView.setRegion(coordinateRegion, animated: true)
        }
        
        setMapAnnotations()
            
    }
    
    func setMapAnnotations() {
        
        let CulcAnnotation = DibsMapAnnotation(buildingNameTitle: "CULC", locationName: "Clough Undergraduate Learning Commons", spotCount: 0, coordinate: CulcCoord)
        self.mapView.addAnnotation(CulcAnnotation)
        
        let VanLeerAnnotation = DibsMapAnnotation(buildingNameTitle: "Van Leer", locationName: "Van Leer ECE Building", spotCount: 20, coordinate: VanLeerCoord)
        self.mapView.addAnnotation(VanLeerAnnotation)
        
        let KlausAnnotation = DibsMapAnnotation(buildingNameTitle: "Klaus", locationName: "Klaus Advanced Computing Building", spotCount: 10, coordinate: KlausCoord)
        self.mapView.addAnnotation(KlausAnnotation)
        
        let HoweyAnnotation = DibsMapAnnotation(buildingNameTitle: "Howey", locationName: "Howey Physics Building", spotCount: 10, coordinate: HoweyCoord)
        self.mapView.addAnnotation(HoweyAnnotation)
        
        let SCAnnotation = DibsMapAnnotation(buildingNameTitle: "Student Center", locationName: "Georgia Tech Student Center", spotCount: 15, coordinate: StudentCenterCoord)
        self.mapView.addAnnotation(SCAnnotation)
        
        let BoggsAnnotation = DibsMapAnnotation(buildingNameTitle: "Boggs", locationName: "Boggs Chemistry Building", spotCount: 15, coordinate: BoggsCoord)
        self.mapView.addAnnotation(BoggsAnnotation)
        
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

extension DibsMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? DibsMapAnnotation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            // custom button
            let calloutButton = UIButton(type: .contactAdd)
            calloutButton.setImage(UIImage(systemName: "plus"), for: .normal)
            calloutButton.tintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            view.rightCalloutAccessoryView = calloutButton
        }
        view.markerTintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        return view
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // open in Maps
//        let location = view.annotation as! Artwork
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMaps(launchOptions: launchOptions)
        let dibsMapAnnotation = view.annotation as! DibsMapAnnotation
        if let buildingNAmeTitle = dibsMapAnnotation.title {
            // add to VC
            
        }
    }
}

extension DibsMapViewController: CLLocationManagerDelegate {
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Recieved New Location Data")
//        if let location = locations.first {
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//            mapView.setRegion(region, animated: true)
//        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}
