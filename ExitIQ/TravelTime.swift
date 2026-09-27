import Foundation


// route travel time
struct TravelTime
{
    // simulation walking speed
    static let walkingSpeed = 1.4


    // time from distance
    static func calculate(
        distance: Double
    ) -> Double
    {
        if distance <= 0
        {
            return 0.0
        }


        return distance / walkingSpeed
    }
}
