

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

     private lazy var mapView: MKMapView = {
       let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = .standard
        //let location = CLLocationCoordinate2D(latitude: 55.755786 , longitude: 37.617633)
       // let area = MKCoordinateRegion(center: location, latitudinalMeters: 30_000, longitudinalMeters: 30_000)
       // map.setRegion(area, animated: false)
        map.addAnnotations(Annotation.make())
         map.showsUserLocation = true
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mapView)
        setConstraints()
        findUserLocation()
 
    }
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            
        ])
    }
    
    func findUserLocation() {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getDirection() {
        let request = MKDirections.Request()
        let from = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.6772, longitude: 37.8932))
        request.source = MKMapItem(placemark: from)
        let destination = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.3604, longitude: 38.0658))
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate{ response, error in
            guard let response = response else {
                print(error?.localizedDescription ?? "No errors")
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
        }
    }

}
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if #available(iOS 14.0, *) {
                switch manager.authorizationStatus {
                case .notDetermined:
                    print("Not determined")
                case .restricted:
                    print("Restricted")
                case .denied:
                    print("Denied")
                case .authorizedAlways:
                    print("Authorized Always")
                case .authorizedWhenInUse:
                    print("Authorized When in Use")
                @unknown default:
                    print("Unknown status")
                }
            }
        }
        
        // iOS 13 and below
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                print("Not determined")
            case .restricted:
                print("Restricted")
            case .denied:
                print("Denied")
            case .authorizedAlways:
                print("Authorized Always")
            case .authorizedWhenInUse:
                print("Authorized When in Use")
            @unknown default:
                print("Unknown status")
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longtitude = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        return renderer
    }
}
