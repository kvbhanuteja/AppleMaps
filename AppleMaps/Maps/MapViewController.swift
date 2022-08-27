//
//  MapViewController.swift
//  AppleMaps
//
//  Created by bhanuteja on 26/08/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapview: MKMapView!
    private var locationManager = CLLocationManager()
    private let viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                updateLocation()
            case .denied, .restricted:
                print("restricted")
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
                locationManager.requestWhenInUseAuthorization()
                print("notDetermined")
            @unknown default:
                break
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
        mapview.showsUserLocation = true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil, !viewModel.locationPinsDropped {
            /* Uncomment if need to set the current location as the region
             let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
             var region = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
             region.center = mapview.userLocation.coordinate
             mapview.region = region
             let annotation = MKPointAnnotation()
             annotation.coordinate = center
             annotation.title = "Current Location"
             mapview.addAnnotation(annotation)
             */
            dropPins()
        }
    }
    
    func dropPins() {
        do {
            let data = try viewModel.getLocations()
            data?.forEach({ location in
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                mapview.addAnnotation(annotation)
            })
            viewModel.locationPinsDropped = true
            let regionRadius = 4000.0
            let center = MKCoordinateRegion(center: (data?.first!)!, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapview.setRegion(center, animated: true)
        } catch {
            print("handle error thrown")
        }
    }
    
}

