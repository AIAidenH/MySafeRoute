import Foundation


// user's current indoor location
struct UserLocation
{
    var floor: Int


    // position on the building map (meter)
    var x: Double
    var y: Double


    // closest beacon
    var nearestSensorID: String?
}
