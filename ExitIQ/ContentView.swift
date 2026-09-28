import SwiftUI


struct ContentView: View
{
    // building with unsafe exit routes
    var dangerousBuilding: BuildingMap
    {
        var building = sampleBuilding


        for index in building.edges.indices
        {
            if building.edges[index].id == "edge5" ||
                building.edges[index].id == "edge7"
            {
                building.edges[index].smokeRisk = 0.90
                building.edges[index].heatRisk = 0.90
                building.edges[index].fireRisk = 0.90
                building.edges[index].crowdRisk = 0.70
                building.edges[index].structuralRisk = 0.80
            }
        }


        return building
    }




    var emergencyDestination: RouteOption?
    {
        RouteEngine.findEmergencyDestination(
            from: "classroom201",
            building: dangerousBuilding
        )
    }




    var body: some View
    {
        VStack(alignment: .leading, spacing: 20)
        {
            Text("ExitIQ Shelter Test")
                .font(.title)
                .fontWeight(.bold)


            Text("All Exits Unsafe")
                .font(.headline)


            if let emergencyDestination
            {
                Text(
                    "Destination: \(emergencyDestination.destinationNodeID)"
                )
                .font(.title2)
                .fontWeight(.bold)


                Text(
                    "Risk: \(emergencyDestination.risk, specifier: "%.2f")"
                )


                Text(
                    "Distance: \(emergencyDestination.distance, specifier: "%.1f") m"
                )
            }
            else
            {
                Text("No Route Available")
            }
        }
        .padding()
    }
}


#Preview
{
    ContentView()
}
