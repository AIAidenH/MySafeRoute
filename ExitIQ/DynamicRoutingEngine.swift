import Foundation


// dynamic route evaluation
struct DynamicRoutingEngine
{
    static func recalculateRoute(
        from startNodeID: String,
        building: BuildingMap,
        userSpeed: Double?,
        hazardArrivalTimes: [String: Double]
    ) -> RouteOption?
    {
        return RouteEngine.findBestExit(
            from: startNodeID,
            building: building,
            userSpeed: userSpeed,
            hazardArrivalTimes: hazardArrivalTimes
        )
    }




    // check if route should change
    static func shouldReroute(
        currentRoute: RouteOption?,
        newRoute: RouteOption?
    ) -> Bool
    {
        guard let newRoute
        else
        {
            return false
        }


        guard let currentRoute
        else
        {
            return true
        }


        if currentRoute.exitNodeID != newRoute.exitNodeID
        {
            return true
        }


        return false
    }
}
