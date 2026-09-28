import Foundation


// user movement tracking
struct UserMovement
{
    // measured walking speed
    static func calculateSpeed(
        distance: Double,
        time: Double
    ) -> Double?
    {
        if distance <= 0 || time <= 0
        {
            return nil
        }


        return distance / time
    }
}
