import Foundation


// hazard movement prediction
struct HazardPrediction
{
    // calculate hazard speed
    static func calculateSpeed
    (
        distance: Double,
        firstTime: Double,
        secondTime: Double
    ) -> Double?
    
    
    {
        let timeDifference = secondTime - firstTime


        if timeDifference <= 0
        {
            return nil
        }


        return distance / timeDifference
    }




    // hazard movement direction
    static func movementDirection(
        firstSensorID: String,
        secondSensorID: String
    ) -> String
    {
        return "\(firstSensorID) → \(secondSensorID)"
    }
    
    
    
    
    // predicted hazard arrival time
    static func calculateArrivalTime(
        currentTime: Double,
        distance: Double,
        speed: Double
    ) -> Double?
    {
        if speed <= 0
        {
            return nil
        }


        let travelTime = distance / speed


        return currentTime + travelTime
    }
}
