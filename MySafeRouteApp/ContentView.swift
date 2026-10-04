import SwiftUI


struct ContentView: View
{
    @State private var currentNodeID = "classroom201"
    @State private var hazardActive = false
    @State private var criticalActive = false
    @State private var showMap = false
    @StateObject private var headingManager =
        DeviceHeadingManager()
    
    
    
    
    var activeBuilding: BuildingMap
    {
        var building = sampleBuilding


        // Exit B hazard
        if hazardActive || criticalActive
        {
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
        }


        // Exit A hazard
        if criticalActive
        {
            if let edgeIndex = building.edges.firstIndex(where:
            {
                $0.id == "edge5"
            })
            {
                building.edges[edgeIndex].smokeRisk = 0.90
                building.edges[edgeIndex].heatRisk = 0.90
                building.edges[edgeIndex].fireRisk = 0.90
                building.edges[edgeIndex].crowdRisk = 0.70
                building.edges[edgeIndex].structuralRisk = 0.80
            }
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




    var totalRemainingDistance: Double
    {
        selectedRoute?.distance ?? 0.0
    }


    
    
    var routeDirection: Double
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


        return routeDirection
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
                criticalActive
                    ? "⚠ CRITICAL · REFUGE ROUTE ACTIVE"
                    : hazardActive
                        ? "⚠ HAZARD DETECTED · ROUTE UPDATED"
                        : "SAFE ROUTE ACTIVE"
            )
            .font(.caption)
            .foregroundStyle(
                criticalActive
                    ? .orange
                    : hazardActive
                        ? .red
                        : .green.opacity(0.65)
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
                    .font(.system(size: 180, weight: .black))
                    .foregroundStyle(
                        Color(
                            red: 0.10,
                            green: 0.95,
                            blue: 0.30
                        )
                    )
                    .shadow(
                        color: Color.green.opacity(0.35),
                        radius: 12
                    )


                Text("0 m")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                    .tracking(-2)
                    .foregroundStyle(.green)
                    .padding(.top, 25)
            }
            else
            {
                Image(systemName: "arrow.up")
                    .font(.system(size: 240, weight: .black))
                    .rotationEffect(
                        .degrees(direction)
                    )
                    .foregroundStyle(
                        Color(
                            red: 0.10,
                            green: 0.95,
                            blue: 0.30
                        )
                    )
                    .shadow(
                        color: Color.green.opacity(0.35),
                        radius: 12
                    )


                Text(
                    "\(distanceToNextDestination, specifier: "%.0f") m"
                )
                .font(.system(size: 60, weight: .black, design: .rounded))
                .tracking(-2)
                .foregroundStyle(
                    Color(
                        red: 0.10,
                        green: 0.95,
                        blue: 0.30
                    )
                )
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


                VStack(alignment: .trailing, spacing: 3)
                {
                    Text(
                        "\(totalRemainingDistance, specifier: "%.0f") m"
                    )
                    .font(.headline)
                    .fontWeight(.bold)


                    Text("REMAINING")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }


            Spacer()


            VStack(spacing: 10)
            {
                Text("DEMO CONTROLS")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary.opacity(0.8))


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
                        .buttonStyle(.borderedProminent)
                        .tint(.gray.opacity(0.35))


                        Button("Hazard")
                        {
                            if hazardActive
                            {
                                hazardActive = false
                            }
                            else
                            {
                                criticalActive = false
                                hazardActive = true
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(
                            hazardActive
                                ? .gray
                                : .gray.opacity(0.35)
                        )
                        
                        
                        
                        Button("Critical")
                        {
                            if criticalActive
                            {
                                criticalActive = false
                            }
                            else
                            {
                                hazardActive = false
                                criticalActive = true
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(
                            criticalActive
                                ? .gray
                                : .gray.opacity(0.35)
                        )
                    }
                    
                    
                    
                    
                    


                    Button("Map")
                    {
                        showMap = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue.opacity(0.70))
                }
                
                
                Text("PROTOTYPE · SIMULATED EMERGENCY DATA")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundStyle(.secondary.opacity(0.65))
                    .padding(.top, 4)
                
                
            }
            .padding(.top, 10)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .padding()
        .background(.black)
        .preferredColorScheme(.dark)
        
        
        .sheet(
            isPresented: $showMap
        )
        {
            if let selectedRoute
            {
                VStack(spacing: 0)
                {
                    VStack(spacing: 4)
                        {
                            Text("EVACUATION MAP")
                                .font(.headline)


                            Text(
                                criticalActive
                                    ? "Refuge route active"
                                    : hazardActive
                                        ? "Route updated due to detected hazard"
                                        : "Current safest route"
                            )
                            .font(.caption)
                            .foregroundStyle(
                                criticalActive
                                    ? .orange
                                    : hazardActive
                                        ? .red
                                        : .green
                            )
                        }
                        .padding(.top, 30)


                        HStack
                        {
                            Spacer()


                            Button
                            {
                                showMap = false
                            }
                            label:
                            {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 26))
                                    .foregroundStyle(.gray)
                            }
                            .offset(y: -34)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)


                    BuildingMapView(
                        building: activeBuilding,
                        currentNodeID: currentNodeID,
                        route: selectedRoute.route,
                        routeDirection: routeDirection,
                        relativeDirection: direction
                    )
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                    .padding()
                }
                .presentationDragIndicator(.visible)
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
