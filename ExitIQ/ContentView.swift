import SwiftUI


struct ContentView: View
{
    // simulated measured speed
    let measuredUserSpeed: Double = 1.2


    // predicted hazard arrival times
    // predicted hazard arrival times
    let hazardArrivalTimes: [String: Double] = [
        "hallwayA": 60.0,
        "hallwayB": 60.0,
        "hallwayC": 60.0,
        "stairA": 60.0,
        "exitA": 60.0,
        "exitB": 5.0
    ]




    var initialRoute: RouteOption?
    {
        RouteEngine.findBestExit(
            from: "classroom201",
            building: sampleBuilding,
            userSpeed: nil,
            hazardArrivalTimes: hazardArrivalTimes
        )
    }




    var predictiveRoute: RouteOption?
    {
        RouteEngine.findBestExit(
            from: "classroom201",
            building: sampleBuilding,
            userSpeed: measuredUserSpeed,
            hazardArrivalTimes: hazardArrivalTimes
        )
    }




    var body: some View
    {
        VStack(alignment: .leading, spacing: 24)
        {
            Text("ExitIQ Dynamic Routing Test")
                .font(.title)
                .fontWeight(.bold)


            VStack(alignment: .leading, spacing: 8)
            {
                Text("Initial Routing")
                    .font(.headline)


                if let initialRoute
                {
                    Text(initialRoute.exitNodeID)
                        .font(.title2)
                        .fontWeight(.bold)


                    Text(
                        "Risk: \(initialRoute.risk, specifier: "%.2f")"
                    )


                    Text(
                        "Distance: \(initialRoute.distance, specifier: "%.1f") m"
                    )
                }
            }


            Divider()


            VStack(alignment: .leading, spacing: 8)
            {
                Text("After Movement + Hazard Prediction")
                    .font(.headline)


                if let predictiveRoute
                {
                    Text(predictiveRoute.exitNodeID)
                        .font(.title2)
                        .fontWeight(.bold)


                    Text(
                        "Distance: \(predictiveRoute.distance, specifier: "%.1f") m"
                    )
                }
            }
        }
        .padding()
    }
}


#Preview
{
    ContentView()
}
