import Foundation


// building route search
struct RouteEngine
{
    // find route between two nodes
    static func findRoute
    (
        from startNodeID: String,
        to destinationNodeID: String,
        building: BuildingMap
    ) -> [String]?
    
    
    {
        var queue: [[String]] = [[startNodeID]]
        var visited: Set<String> = [startNodeID]


        while !queue.isEmpty
        {
            let path = queue.removeFirst()


            guard let currentNodeID = path.last
            else
            {
                continue
            }


            if currentNodeID == destinationNodeID
            {
                return path
            }


            let connectedNodeIDs = neighbors(
                of: currentNodeID,
                edges: building.edges
            )


            for nodeID in connectedNodeIDs
            {
                if !visited.contains(nodeID)
                {
                    visited.insert(nodeID)


                    var newPath = path
                    newPath.append(nodeID)
                    queue.append(newPath)
                }
            }
        }


        return nil
    }

    
    
    
    // total route distance
    static func calculateDistance(
        for route: [String],
        building: BuildingMap
    ) -> Double
    {
        if route.count < 2
        {
            return 0.0
        }
        
        
        var totalDistance = 0.0


        for index in 0..<(route.count - 1)
        {
            let fromNodeID = route[index]
            let toNodeID = route[index + 1]


            if let edge = building.edges.first(where:
            {
                ($0.fromNodeID == fromNodeID &&
                 $0.toNodeID == toNodeID) ||
                ($0.fromNodeID == toNodeID &&
                 $0.toNodeID == fromNodeID)
            })
            {
                totalDistance += edge.distance
            }
        }


        return totalDistance
    }




    // average route risk
    static func calculateRisk(
        for route: [String],
        building: BuildingMap
    ) -> Double
    {
        if route.count < 2
        {
            return 0.0
        }
        
        
        var totalRisk = 0.0
        var edgeCount = 0


        for index in 0..<(route.count - 1)
        {
            let fromNodeID = route[index]
            let toNodeID = route[index + 1]


            if let edge = building.edges.first(where:
            {
                ($0.fromNodeID == fromNodeID &&
                 $0.toNodeID == toNodeID) ||
                ($0.fromNodeID == toNodeID &&
                 $0.toNodeID == fromNodeID)
            })
            {
                totalRisk += RiskModel.calculateRisk(for: edge)
                edgeCount += 1
            }
        }


        if edgeCount == 0
        {
            return 0.0
        }


        return totalRisk / Double(edgeCount)
    }


    

    // evaluate all exits
    static func evaluateExits(
        from startNodeID: String,
        building: BuildingMap
    ) -> [RouteOption]
    {
        let exitNodes = building.nodes.filter
        {
            $0.type == .exit
        }


        var routeOptions: [RouteOption] = []


        for exitNode in exitNodes
        {
            guard let route = findRoute(
                from: startNodeID,
                to: exitNode.id,
                building: building
            )
            else
            {
                continue
            }


            let distance = calculateDistance(
                for: route,
                building: building
            )


            let risk = calculateRisk(
                for: route,
                building: building
            )


            let option = RouteOption(
                exitNodeID: exitNode.id,
                route: route,
                distance: distance,
                risk: risk
            )


            routeOptions.append(option)
        }


        return routeOptions
    }
    
    
    
    
    // choose best exit
    static func findSafestExit(
        from startNodeID: String,
        building: BuildingMap
    ) -> RouteOption?
    {
        let routeOptions = evaluateExits(
            from: startNodeID,
            building: building
        )


        guard !routeOptions.isEmpty
        else
        {
            return nil
        }


        let riskThreshold = 0.10 // ---> THE SCORE TO COMPARE BETWEEN DISTANCE AND RISK


        return routeOptions.min
        {
            firstOption, secondOption in


            let riskDifference =
                abs(firstOption.risk - secondOption.risk)


            if riskDifference < riskThreshold
            {
                return firstOption.distance < secondOption.distance
            }


            return firstOption.risk < secondOption.risk
        }
    }
    
    
    
    
    // connected building nodes
    private static func neighbors(
        of nodeID: String,
        edges: [BuildingEdge]
    ) -> [String]
    {
        var nodeIDs: [String] = []


        for edge in edges
        {
            if edge.fromNodeID == nodeID
            {
                nodeIDs.append(edge.toNodeID)
            }
            else if edge.toNodeID == nodeID
            {
                nodeIDs.append(edge.fromNodeID)
            }
        }


        return nodeIDs
    }
}
