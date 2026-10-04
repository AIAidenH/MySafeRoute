import Foundation


// route travel time
struct TravelTime
{
    // simulation walking speed
    static let walkingSpeed = 1.4


    // travel time from distance
    static func calculate
    (
        distance: Double,
        userSpeed: Double? = nil
    ) -> Double
    
    
    {
        if distance <= 0
        {
            return 0.0
        }


        let speed = userSpeed ?? walkingSpeed


        if speed <= 0
        {
            return 0.0
        }


        return distance / speed
    }
}
