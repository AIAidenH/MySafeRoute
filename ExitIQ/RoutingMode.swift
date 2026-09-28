import Foundation


// routing calculation mode
enum RoutingMode
{
    case initial
    case predictive
}




// routing mode selection
struct RoutingModeManager
{
    static func determineMode(
        userSpeed: Double?
    ) -> RoutingMode
    {
        if userSpeed == nil
        {
            return .initial
        }


        return .predictive
    }
}
