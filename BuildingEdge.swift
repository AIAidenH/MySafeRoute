import Foundation


// represents a walkable connection between two building locations
struct BuildingEdge: Identifiable {
    let id: String

    
    let fromNodeID: String
    let toNodeID: String

    
    // physical distance between the two locations, in meters
    let distance: Double

    
    // dynamic risk values used by the routing engine
    var smokeRisk: Double
    var heatRisk: Double
    var fireRisk: Double
    var crowdRisk: Double
    var structuralRisk: Double
}
