import Foundation
import CoreLocation

class CurrentLocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let defaultLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.6887596638332, longitude: 5.288556717181872)
    @Published var currentLocation: CLLocation?
    @Published var locationAccessDecisionMade: Bool = false
    static let shared = CurrentLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestUserLocationAccess() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentUserLocation() -> CLLocationCoordinate2D {
        currentLocation?.coordinate ?? defaultLocation
    }
}

extension CurrentLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationAccessDecisionMade = false
        case .restricted:
            locationAccessDecisionMade = true
        case .denied:
            locationAccessDecisionMade = true
        case .authorizedAlways:
            locationAccessDecisionMade = true
        case .authorizedWhenInUse:
            locationAccessDecisionMade = true
        @unknown default:
            locationAccessDecisionMade = false
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.currentLocation = location
    }
}
