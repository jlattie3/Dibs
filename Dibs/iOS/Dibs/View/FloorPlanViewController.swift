//
//  FloorPlanViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 4/6/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import MapKit

class FloorPlanViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.removeAnnotations(mapView.annotations)

        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        var locations: [CLLocationCoordinate2D] =
        [CLLocationCoordinate2D(latitude: 33.775134, longitude: -84.39664)
        ,CLLocationCoordinate2D(latitude: 33.775134, longitude: -84.396152)
        ,CLLocationCoordinate2D(latitude: 33.774202, longitude: -84.396168)
        ,CLLocationCoordinate2D(latitude: 33.774193, longitude: -84.396645)]
        
        
        let polygon = MKPolygon(coordinates: &locations, count: locations.count)
        mapView.addOverlay(polygon)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        print("Render")
        let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
        renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.black
        renderer.lineWidth = 1
        return renderer
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

extension FloorPlanViewController: MKMapViewDelegate {
    
}

extension FloorPlanViewController: CLLocationManagerDelegate {
    
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
