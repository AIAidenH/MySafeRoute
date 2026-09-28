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
    static func calculateDistance
    (
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
    static func calculateRisk
    (
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
    static func evaluateExits
    (
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


        let riskThreshold = 0.10


        guard let minimumRisk =
            routeOptions.map({ $0.risk }).min()
        else
        {
            return nil
        }


        let acceptableRoutes = routeOptions.filter
        {
            ($0.risk - minimumRisk) < riskThreshold
        }


        return acceptableRoutes.min
        {
            $0.distance < $1.distance
        }
    }
    
    
    
    
    // arrival time at each node
    static func calculateArrivalTimes
    (
        for route: [String],
        building: BuildingMap,
        userSpeed: Double? = nil
    ) -> [String: Double]
    
    
    {
        guard !route.isEmpty
        else
        {
            return [:]
        }


        var arrivalTimes: [String: Double] = [
            route[0]: 0.0
        ]


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


                arrivalTimes[toNodeID] = TravelTime.calculate(
                    distance: totalDistance,
                    userSpeed: userSpeed
                )
            }
        }


        return arrivalTimes
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
    
    
    
    
    // choose route by routing mode
    static func findBestExit(
        from startNodeID: String,
        building: BuildingMap,
        userSpeed: Double?,
        hazardArrivalTimes: [String: Double]
    ) -> RouteOption?
    {
        let mode = RoutingModeManager.determineMode(
            userSpeed: userSpeed
        )


        if mode == .initial
        {
            return findSafestExit(
                from: startNodeID,
                building: building
            )
        }


        guard let userSpeed
        else
        {
            return nil
        }


        let routeOptions = evaluateExits(
            from: startNodeID,
            building: building
        )


        guard !routeOptions.isEmpty
        else
        {
            return nil
        }


        let riskThreshold = 0.10


        let predictiveRoutes = routeOptions.map
        {
            option in


            let predictiveRisk = calculatePredictiveRouteRisk(
                for: option,
                building: building,
                userSpeed: userSpeed,
                hazardArrivalTimes: hazardArrivalTimes
            )


            return (
                option: option,
                risk: predictiveRisk
            )
        }


        guard let minimumRisk =
            predictiveRoutes.map({ $0.risk }).min()
        else
        {
            return nil
        }


        let acceptableRoutes = predictiveRoutes.filter
        {
            ($0.risk - minimumRisk) < riskThreshold
        }


        return acceptableRoutes.min
        {
            $0.option.distance < $1.option.distance
        }?.option
    }
    
    
    
    
    // predictive risk for route
    static func calculatePredictiveRouteRisk
    (
        for option: RouteOption,
        building: BuildingMap,
        userSpeed: Double,
        hazardArrivalTimes: [String: Double]
    ) -> Double
    
    
    {
        let userArrivalTimes = calculateArrivalTimes(
            for: option.route,
            building: building,
            userSpeed: userSpeed
        )


        var totalRisk = 0.0
        var riskCount = 0


        for nodeID in option.route
        {
            guard let userArrivalTime = userArrivalTimes[nodeID],
                  let hazardArrivalTime = hazardArrivalTimes[nodeID]
            else
            {
                continue
            }


            let risk = PredictiveRisk.calculateArrivalRisk(
                userArrivalTime: userArrivalTime,
                hazardArrivalTime: hazardArrivalTime
            )


            totalRisk += risk
            riskCount += 1
        }


        if riskCount == 0
        {
            return option.risk
        }


        let predictedRisk =
            totalRisk / Double(riskCount)


        let combinedRisk =
            (option.risk * 0.6) +
            (predictedRisk * 0.4)


        return min(max(combinedRisk, 0.0), 1.0)
    }
}
