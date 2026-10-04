import Foundation


// holds the simulated building layout used by MySafeRouteApp
struct BuildingMap {
    var nodes: [BuildingNode]
    var edges: [BuildingEdge]
}


// sample one-floor school layout
let sampleBuilding = BuildingMap(
    nodes: [
        BuildingNode(
            id: "classroom201",
            name: "Classroom 201",
            floor: 2,
            x: 0,
            y: 10,
            type: .room,
            sensor: nil
        ),


        BuildingNode(
            id: "hallwayA",
            name: "East Hallway A",
            floor: 2,
            x: 6,
            y: 10,
            type: .hallway,
            sensor: sensorA
        ),


        BuildingNode(
            id: "hallwayB",
            name: "East Hallway B",
            floor: 2,
            x: 14,
            y: 10,
            type: .hallway,
            sensor: sensorB
        ),


        BuildingNode(
            id: "hallwayC",
            name: "East Hallway C",
            floor: 2,
            x: 22,
            y: 10,
            type: .hallway,
            sensor: sensorC
        ),


        BuildingNode(
            id: "stairA",
            name: "Stair A",
            floor: 2,
            x: 22,
            y: 0,
            type: .stair,
            sensor: nil
        ),


        BuildingNode(
            id: "exitA",
            name: "Exit A",
            floor: 2,
            x: 22,
            y: -12,
            type: .exit,
            sensor: nil
        ),


        BuildingNode(
            id: "exitB",
            name: "Exit B",
            floor: 2,
            x: 6,
            y: 20,
            type: .exit,
            sensor: nil
        ),


        BuildingNode(
            id: "shelterA",
            name: "Refuge Room A",
            floor: 2,
            x: 14,
            y: 15,
            type: .shelter,
            sensor: nil
        )
    ],

    
    edges: [
        BuildingEdge(
            id: "edge1",
            fromNodeID: "classroom201",
            toNodeID: "hallwayA",
            distance: 6.0,
            smokeRisk: 0.0,
            heatRisk: 0.0,
            fireRisk: 0.0,
            crowdRisk: 0.10,
            structuralRisk: 0.0
        ),

        
        BuildingEdge(
            id: "edge2",
            fromNodeID: "hallwayA",
            toNodeID: "hallwayB",
            distance: 8.0,
            smokeRisk: 0.02,
            heatRisk: 0.0,
            fireRisk: 0.0,
            crowdRisk: 0.15,
            structuralRisk: 0.0
        ),

        
        BuildingEdge(
            id: "edge3",
            fromNodeID: "hallwayB",
            toNodeID: "hallwayC",
            distance: 8.0,
            smokeRisk: 0.18,
            heatRisk: 0.10,
            fireRisk: 0.05,
            crowdRisk: 0.20,
            structuralRisk: 0.0
        ),
        

        BuildingEdge(
            id: "edge4",
            fromNodeID: "hallwayC",
            toNodeID: "stairA",
            distance: 10.0,
            smokeRisk: 0.61,
            heatRisk: 0.50,
            fireRisk: 0.40,
            crowdRisk: 0.25,
            structuralRisk: 0.10
        ),

        
        BuildingEdge(
            id: "edge5",
            fromNodeID: "stairA",
            toNodeID: "exitA",
            distance: 12.0,
            smokeRisk: 0.15,
            heatRisk: 0.05,
            fireRisk: 0.0,
            crowdRisk: 0.20,
            structuralRisk: 0.0
        ),

        
        BuildingEdge(
            id: "edge6",
            fromNodeID: "hallwayB",
            toNodeID: "shelterA",
            distance: 5.0,
            smokeRisk: 0.05,
            heatRisk: 0.0,
            fireRisk: 0.0,
            crowdRisk: 0.05,
            structuralRisk: 0.0
        ),
        
        
        BuildingEdge(
            id: "edge7",
            fromNodeID: "hallwayA",
            toNodeID: "exitB",
            distance: 18.0,
            smokeRisk: 0.10,
            heatRisk: 0.10,
            fireRisk: 0.05,
            crowdRisk: 0.15,
            structuralRisk: 0.05
        )
    ]
)
