import SwiftUI


struct ContentView: View
{
    let measuredUserSpeed = 1.2


    // hazard before sensor update
    let initialHazardTimes: [String: Double] = [
        "hallwayA": 60.0,
        "hallwayB": 60.0,
        "hallwayC": 60.0,
        "stairA": 60.0,
        "exitA": 60.0,
        "exitB": 60.0
    ]


    // hazard after sensor update
    let updatedHazardTimes: [String: Double] = [
        "hallwayA": 60.0,
        "hallwayB": 60.0,
        "hallwayC": 60.0,
        "stairA": 60.0,
        "exitA": 60.0,
        "exitB": 5.0
    ]




    var currentRoute: RouteOption?
    {
        DynamicRoutingEngine.recalculateRoute(
            from: "classroom201",
            building: sampleBuilding,
            userSpeed: measuredUserSpeed,
            hazardArrivalTimes: initialHazardTimes
        )
    }




    var updatedRoute: RouteOption?
    {
        DynamicRoutingEngine.recalculateRoute(
            from: "classroom201",
            building: sampleBuilding,
            userSpeed: measuredUserSpeed,
            hazardArrivalTimes: updatedHazardTimes
        )
    }




    var shouldReroute: Bool
    {
        DynamicRoutingEngine.shouldReroute(
            currentRoute: currentRoute,
            newRoute: updatedRoute
        )
    }




    var body: some View
    {
        VStack(alignment: .leading, spacing: 24)
        {
            Text("ExitIQ Dynamic Rerouting Test")
                .font(.title)
                .fontWeight(.bold)


            Text("Before Sensor Update")
                .font(.headline)


            Text(currentRoute?.exitNodeID ?? "No Route")
                .font(.title2)
                .fontWeight(.bold)


            Divider()


            Text("After Sensor Update")
                .font(.headline)


            Text(updatedRoute?.exitNodeID ?? "No Route")
                .font(.title2)
                .fontWeight(.bold)


            Divider()


            Text(
                shouldReroute
                ? "Reroute: YES"
                : "Reroute: NO"
            )
            .font(.title2)
            .fontWeight(.bold)
        }
        .padding()
    }
}


#Preview
{
    ContentView()
}
