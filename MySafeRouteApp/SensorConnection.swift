import Foundation


// connection between sensors
struct SensorConnection: Identifiable
{
    let id: String


    // connected sensors
    let fromSensorID: String
    let toSensorID: String


    // distance between sensors (meter)
    let distance: Double
}
