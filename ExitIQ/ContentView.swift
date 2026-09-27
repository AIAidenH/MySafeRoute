import SwiftUI


struct ContentView: View
{
    var routeOptions: [RouteOption]
    {
        RouteEngine.evaluateExits(
            from: "classroom201",
            building: sampleBuilding
        )
    }




    var selectedRoute: RouteOption?
    {
        RouteEngine.findSafestExit(
            from: "classroom201",
            building: sampleBuilding
        )
    }




    var body: some View
    {
        VStack(alignment: .leading, spacing: 24)
        {
            Text("ExitIQ Route Selection")
                .font(.title)
                .fontWeight(.bold)


            ForEach(
                Array(routeOptions.enumerated()),
                id: \.offset
            )
            {
                index, option in


                VStack(alignment: .leading, spacing: 6)
                {
                    Text(option.exitNodeID)
                        .font(.headline)


                    Text("Distance: \(option.distance, specifier: "%.1f") m")


                    Text("Risk: \(option.risk, specifier: "%.2f")")
                }
            }


            Divider()


            if let selectedRoute
            {
                Text("Selected Exit")
                    .font(.headline)


                Text(selectedRoute.exitNodeID)
                    .font(.title)
                    .fontWeight(.bold)


                Text("Distance: \(selectedRoute.distance, specifier: "%.1f") m")


                Text("Risk: \(selectedRoute.risk, specifier: "%.2f")")


                Text(selectedRoute.route.joined(separator: " → "))
                    .font(.caption)
            }
            else
            {
                Text("No exit route available")
            }
        }
        .padding()
    }
}


#Preview
{
    ContentView()
}
