import SwiftUI


struct ContentView: View
{
    @State private var currentNodeID = "classroom201"
    @State private var hazardActive = false
    @State private var showMap = false
    @StateObject private var headingManager =
        DeviceHeadingManager()
    
    
    
    
    var activeBuilding: BuildingMap
    {
        if !hazardActive
        {
            return sampleBuilding
        }


        var building = sampleBuilding


        if let edgeIndex = building.edges.firstIndex(where:
        {
            $0.id == "edge7"
        })
        {
            building.edges[edgeIndex].smokeRisk = 0.90
            building.edges[edgeIndex].heatRisk = 0.90
            building.edges[edgeIndex].fireRisk = 0.90
            building.edges[edgeIndex].crowdRisk = 0.70
            building.edges[edgeIndex].structuralRisk = 0.80
        }


        return building
    }




    var selectedRoute: RouteOption?
    {
        RouteEngine.findEmergencyDestination(
            from: currentNodeID,
            building: activeBuilding
        )
    }




    var nextDestinationName: String
    {
        guard let selectedRoute,
              let currentIndex = selectedRoute.route.firstIndex(
                of: currentNodeID
              )
        else
        {
            return "No Safe Route"
        }


        let nextIndex = currentIndex + 1


        guard nextIndex < selectedRoute.route.count
        else
        {
            return "Destination Reached"
        }


        let nextNodeID = selectedRoute.route[nextIndex]


        return activeBuilding.nodes.first(where:
        {
            $0.id == nextNodeID
        })?.name ?? nextNodeID
    }




    var distanceToNextDestination: Double
    {
        guard let selectedRoute
        else
        {
            return 0.0
        }


        return NavigationEngine.distanceToNextNode(
            for: selectedRoute.route,
            currentNodeID: currentNodeID,
            building: activeBuilding
        ) ?? 0.0
    }




    var currentLocationName: String
    {
        activeBuilding.nodes.first(where:
        {
            $0.id == currentNodeID
        })?.name ?? currentNodeID
    }
    
    
    
    
    var finalDestinationName: String
    {
        guard let selectedRoute,
              let destination = activeBuilding.nodes.first(where:
              {
                  $0.id == selectedRoute.destinationNodeID
              })
        else
        {
            return ""
        }


        return destination.name
    }




    var totalRemainingDistance: Double
    {
        selectedRoute?.distance ?? 0.0
    }




    var direction: Double
    {
        guard let selectedRoute,
              let routeDirection =
                NavigationEngine.directionToNextNode(
                    for: selectedRoute.route,
                    currentNodeID: currentNodeID,
                    building: activeBuilding
                )
        else
        {
            return 0.0
        }


        return HeadingEngine.relativeDirection(
            routeDirection: routeDirection,
            deviceHeading: headingManager.heading
        )
    }




    var body: some View
    {
        VStack(spacing: 0)
        {
            Spacer()
            
            
            Text(
                hazardActive
                    ? "⚠ HAZARD DETECTED · ROUTE UPDATED"
                    : "SAFE ROUTE ACTIVE"
            )
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(
                hazardActive
                    ? .red
                    : .secondary
            )
            .padding(.bottom, 12)


            Text(nextDestinationName)
                .font(.title2)
                .fontWeight(.bold)


            Text(
                selectedRoute?.route.count == 1
                    ? "ARRIVED"
                    : "NEXT"
            )
            .font(.caption)
            .foregroundStyle(.secondary)


            Spacer()


            if selectedRoute?.route.count == 1
            {
                Image(systemName: "checkmark")
                    .font(.system(size: 130, weight: .black))


                Text("0 m")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.top, 25)
            }
            else
            {
                Image(systemName: "arrow.up")
                    .font(.system(size: 150, weight: .black))
                    .rotationEffect(
                        .degrees(direction)
                    )


                Text(
                    "\(distanceToNextDestination, specifier: "%.0f") m"
                )
                .font(.system(size: 34, weight: .bold))
                .padding(.top, 25)
            }


            Spacer()


            HStack(alignment: .center)
            {
                VStack(alignment: .leading, spacing: 3)
                {
                    Text(currentLocationName)
                        .font(.headline)


                    Text("CURRENT LOCATION")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }


                Spacer()


                Text(
                    "\(totalRemainingDistance, specifier: "%.0f") m"
                )
                .font(.subheadline)
                .fontWeight(.semibold)
            }


            Spacer()


            VStack(spacing: 10)
            {
                Text("DEMO CONTROLS")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)


                HStack(spacing: 10)
                {
                    if let selectedRoute,
                       selectedRoute.route.count > 1
                    {
                        Button("Move")
                        {
                            moveToNextNode(
                                route: selectedRoute.route
                            )
                        }
                        .buttonStyle(.bordered)
                    }


                    Button(
                        hazardActive
                            ? "Clear Hazard"
                            : "Hazard"
                    )
                    {
                        hazardActive.toggle()
                    }
                    .buttonStyle(.bordered)


                    // building map
                    Button("Map")
                    {
                        showMap = true
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity)
        .padding()
        
        
        .sheet(
            isPresented: $showMap
        )
        {
            if let selectedRoute
            {
                BuildingMapView(
                    building: activeBuilding,
                    currentNodeID: currentNodeID,
                    route: selectedRoute.route
                )
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .padding()
            }
        }
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
