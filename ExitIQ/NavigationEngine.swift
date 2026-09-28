import Foundation


// live navigation guidance
struct NavigationEngine
{
    static func instruction
    (
        for nodeID: String,
        building: BuildingMap
    ) -> String
    
    
    {
        guard let node = building.nodes.first(where:
        {
            $0.id == nodeID
        })
        else
        {
            return "Continue to next location"
        }


        switch node.type
        {
        case .room:
            return "Leave \(node.name)"


        case .hallway:
            return "Proceed to \(node.name)"


        case .stair:
            return "Use \(node.name)"


        case .exit:
            return "Exit through \(node.name)"


        case .shelter:
            return "Proceed to \(node.name)"
        }
    }
    
    
    
    
    // create instructions for route
    static func createInstructions
    (
        for route: [String],
        building: BuildingMap
    ) -> [String]
    
    
    {
        var instructions: [String] = []


        for nodeID in route
        {
            let routeInstruction = instruction(
                for: nodeID,
                building: building
            )


            instructions.append(routeInstruction)
        }


        return instructions
    }
    
    
    
    
    // next navigation instruction
    static func nextInstruction
    (
        for route: [String],
        currentNodeID: String,
        building: BuildingMap
    ) -> String?
    
    
    {
        guard let currentIndex = route.firstIndex(
            of: currentNodeID
        )
        else
        {
            return nil
        }


        let nextIndex = currentIndex + 1


        guard nextIndex < route.count
        else
        {
            return nil
        }


        let nextNodeID = route[nextIndex]


        return instruction(
            for: nextNodeID,
            building: building
        )
    }
    
    
    
    
    // distance to next node
    static func distanceToNextNode
    (
        for route: [String],
        currentNodeID: String,
        building: BuildingMap
    ) -> Double?
    
    
    {
        guard let currentIndex = route.firstIndex(
            of: currentNodeID
        )
        else
        {
            return nil
        }


        let nextIndex = currentIndex + 1


        guard nextIndex < route.count
        else
        {
            return nil
        }


        let nextNodeID = route[nextIndex]


        guard let edge = building.edges.first(where:
        {
            ($0.fromNodeID == currentNodeID &&
             $0.toNodeID == nextNodeID) ||
            ($0.fromNodeID == nextNodeID &&
             $0.toNodeID == currentNodeID)
        })
        else
        {
            return nil
        }


        return edge.distance
    }
    
    
    
    
    // direction to next node
    static func directionToNextNode
    (
        for route: [String],
        currentNodeID: String,
        building: BuildingMap
    ) -> Double?
    
    
    {
        guard let currentIndex = route.firstIndex(
            of: currentNodeID
        )
        else
        {
            return nil
        }


        let nextIndex = currentIndex + 1


        guard nextIndex < route.count
        else
        {
            return nil
        }


        let nextNodeID = route[nextIndex]


        guard let currentNode = building.nodes.first(where:
        {
            $0.id == currentNodeID
        }),
        let nextNode = building.nodes.first(where:
        {
            $0.id == nextNodeID
        })
        else
        {
            return nil
        }


        let deltaX = nextNode.x - currentNode.x
        let deltaY = nextNode.y - currentNode.y


        let angle = atan2(
            deltaX,
            deltaY
        )


        return angle * 180 / .pi
    }
}
