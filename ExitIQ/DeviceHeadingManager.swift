import Foundation
import CoreLocation
import Combine


// device heading
final class DeviceHeadingManager: NSObject, ObservableObject, CLLocationManagerDelegate
{
    private let locationManager = CLLocationManager()


    @Published var heading = 0.0




    override init()
    {
        super.init()


        locationManager.delegate = self
        locationManager.headingFilter = 2
        locationManager.startUpdatingHeading()
    }




    func locationManager(
        _ manager: CLLocationManager,
        didUpdateHeading newHeading: CLHeading
    )
    {
        guard newHeading.headingAccuracy >= 0
        else
        {
            return
        }


        heading = newHeading.magneticHeading
    }
}
