import SwiftUI


struct ContentView: View
{
    @State private var currentNodeID = "classroom201"




    var selectedRoute: RouteOption?
    {
        RouteEngine.findEmergencyDestination(
            from: currentNodeID,
            building: sampleBuilding
        )
    }




    var nextInstruction: String
    {
        guard let selectedRoute
        else
        {
            return "No safe route available"
        }


        return NavigationEngine.nextInstruction(
            for: selectedRoute.route,
            currentNodeID: currentNodeID,
            building: sampleBuilding
        ) ?? "Destination reached"
    }




    var distanceToNextNode: Double?
    {
        guard let selectedRoute
        else
        {
            return nil
        }


        return NavigationEngine.distanceToNextNode(
            for: selectedRoute.route,
            currentNodeID: currentNodeID,
            building: sampleBuilding
        )
    }




    var body: some View
    {
        VStack(alignment: .leading, spacing: 20)
        {
            Text("ExitIQ Live Navigation Test")
                .font(.title)
                .fontWeight(.bold)


            Text("Current Location")
                .font(.headline)


            Text(currentNodeID)


            Divider()


            if let selectedRoute
            {
                Text("Destination")
                    .font(.headline)


                Text(selectedRoute.destinationNodeID)


                Text("Next Instruction")
                    .font(.headline)


                Text(nextInstruction)
                    .font(.title2)
                    .fontWeight(.bold)


                if let distanceToNextNode
                {
                    Text(
                        "\(distanceToNextNode, specifier: "%.1f") m"
                    )
                    .font(.title3)
                }


                Button("Move to Next Location")
                {
                    moveToNextNode(
                        route: selectedRoute.route
                    )
                }
                .buttonStyle(.borderedProminent)
            }
            else
            {
                Text("No safe route available")
            }
        }
        .padding()
    }




    // simulate user movement
    func moveToNextNode(
        route: [String]
    )
    {
        guard let currentIndex = route.firstIndex(
            of: currentNodeID
        )
        else
        {
            return
        }


        let nextIndex = currentIndex + 1


        guard nextIndex < route.count
        else
        {
            return
        }


        currentNodeID = route[nextIndex]
    }
}


#Preview
{
    ContentView()
}
