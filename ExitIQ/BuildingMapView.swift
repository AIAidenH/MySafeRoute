import SwiftUI


struct BuildingMapView: View
{
    let building: BuildingMap
    let currentNodeID: String
    let route: [String]


    var body: some View
    {
        GeometryReader
        {
            geometry in


            ZStack
            {
                // building connections
                ForEach(building.edges)
                {
                    edge in


                    if let fromNode = node(
                        with: edge.fromNodeID
                    ),
                    let toNode = node(
                        with: edge.toNodeID
                    )
                    {
                        Path
                        {
                            path in


                            path.move(
                                to: position(
                                    for: fromNode,
                                    in: geometry.size
                                )
                            )


                            path.addLine(
                                to: position(
                                    for: toNode,
                                    in: geometry.size
                                )
                            )
                        }
                        .stroke(
                            .gray,
                            lineWidth: 4
                        )
                    }
                }
                
                
                // selected route
                Path
                {
                    path in


                    guard let firstNodeID = route.first,
                          let firstNode = node(
                            with: firstNodeID
                          )
                    else
                    {
                        return
                    }


                    path.move(
                        to: position(
                            for: firstNode,
                            in: geometry.size
                        )
                    )


                    for nodeID in route.dropFirst()
                    {
                        if let routeNode = node(
                            with: nodeID
                        )
                        {
                            path.addLine(
                                to: position(
                                    for: routeNode,
                                    in: geometry.size
                                )
                            )
                        }
                    }
                }
                .stroke(
                    .green,
                    style: StrokeStyle(
                        lineWidth: 8,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                
                
                // hazard warnings
                ForEach(building.edges)
                {
                    edge in


                    if isHazardous(
                        edge
                    ),
                    let fromNode = node(
                        with: edge.fromNodeID
                    ),
                    let toNode = node(
                        with: edge.toNodeID
                    )
                    {
                        ZStack
                        {
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 36))
                                .foregroundStyle(.yellow)


                            Image(systemName: "exclamationmark")
                                .font(.system(size: 17, weight: .black))
                                .foregroundStyle(.red)
                                .offset(y: 2)
                        }
                        .position(
                            midpoint(
                                between: fromNode,
                                and: toNode,
                                in: geometry.size
                            )
                        )
                    }
                }


                // building nodes
                ForEach(building.nodes)
                {
                    node in


                    ZStack
                    {
                        if node.id == currentNodeID
                        {
                            ZStack
                            {
                                Circle()
                                    .fill(.blue)
                                    .frame(
                                        width: 32,
                                        height: 32
                                    )


                                Image(systemName: "location.fill")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                        }
                        else
                        {
                            switch node.type
                            {
                            case .exit:
                                Image(systemName: "door.left.hand.open")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundStyle(.white)


                            case .shelter:
                                Image(systemName: "shield.fill")
                                    .font(.system(size: 18, weight: .bold))


                            default:
                                Circle()
                                    .frame(
                                        width: 14,
                                        height: 14
                                    )
                            }
                        }


                        Text(node.name)
                            .font(.caption2)
                            .fixedSize()
                            .offset(
                                x: labelOffset(
                                    for: node
                                ).width,
                                y: labelOffset(
                                    for: node
                                ).height
                            )
                    }
                    .position(
                        position(
                            for: node,
                            in: geometry.size
                        )
                    )
                }
            }
        }
    }




    // find building node
    func node(
        with id: String
    ) -> BuildingNode?
    {
        building.nodes.first
        {
            $0.id == id
        }
    }
    
    
    
    
    // severe hazard
    func isHazardous(
        _ edge: BuildingEdge
    ) -> Bool
    {
        edge.smokeRisk >= 0.80
            || edge.heatRisk >= 0.80
            || edge.fireRisk >= 0.80
            || edge.structuralRisk >= 0.80
    }




    // edge midpoint
    func midpoint(
        between firstNode: BuildingNode,
        and secondNode: BuildingNode,
        in size: CGSize
    ) -> CGPoint
    {
        let firstPosition = position(
            for: firstNode,
            in: size
        )


        let secondPosition = position(
            for: secondNode,
            in: size
        )


        return CGPoint(
            x: (
                firstPosition.x
                    + secondPosition.x
            ) / 2,
            y: (
                firstPosition.y
                    + secondPosition.y
            ) / 2
        )
    }

    
    
    
    // label position
    func labelOffset(
        for node: BuildingNode
    ) -> CGSize
    {
        switch node.id
        {
        case "classroom201":
            return CGSize(
                width: -5,
                height: 24
            )


        case "hallwayA":
            return CGSize(
                width: 0,
                height: 42
            )


        case "hallwayB":
            return CGSize(
                width: 0,
                height: 24
            )


        case "hallwayC":
            return CGSize(
                width: 25,
                height: -22
            )


        case "stairA":
            return CGSize(
                width: 35,
                height: 0
            )


        case "exitA":
            return CGSize(
                width: 0,
                height: 25
            )


        case "exitB":
            return CGSize(
                width: 0,
                height: -25
            )


        case "shelterA":
            return CGSize(
                width: 0,
                height: -25
            )


        default:
            return CGSize(
                width: 0,
                height: 24
            )
        }
    }
    



    // map position
    func position(
        for node: BuildingNode,
        in size: CGSize
    ) -> CGPoint
    {
        let scale = min(
            size.width / 35,
            size.height / 40
        )


        let centerX = size.width / 2
        let centerY = size.height / 2


        return CGPoint(
            x: centerX + (node.x - 12) * scale,
            y: centerY - node.y * scale
        )
    }
}




#Preview
{
    var building = sampleBuilding


    if let edgeIndex = building.edges.firstIndex(where:
    {
        $0.id == "edge7"
    })
    {
        building.edges[edgeIndex].smokeRisk = 0.90
        building.edges[edgeIndex].heatRisk = 0.90
        building.edges[edgeIndex].fireRisk = 0.90
        building.edges[edgeIndex].structuralRisk = 0.80
    }


    return BuildingMapView(
        building: building,
        currentNodeID: "classroom201",
        route: [
            "classroom201",
            "hallwayA",
            "hallwayB",
            "hallwayC",
            "stairA",
            "exitA"
        ]
    )
    .padding()
}
