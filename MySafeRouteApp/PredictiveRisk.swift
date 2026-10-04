import Foundation


// future route risk
struct PredictiveRisk
{
    // risk based on hazard arrival
    static func calculateArrivalRisk
    (
        userArrivalTime: Double,
        hazardArrivalTime: Double
    ) -> Double
    
    
    {
        let timeDifference = hazardArrivalTime - userArrivalTime


        if timeDifference <= 0
        {
            return 1.0
        }


        if timeDifference <= 10
        {
            return 0.8
        }


        if timeDifference <= 30
        {
            return 0.5
        }


        return 0.1
    }
}
