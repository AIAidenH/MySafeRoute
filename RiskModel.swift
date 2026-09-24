import Foundation


// calculates a combined risk score for a building path
struct RiskModel {

    
    // risk weights can be adjusted later as the simulation becomes more realistic
    static let smokeWeight = 0.25
    static let heatWeight = 0.25
    static let fireWeight = 0.30
    static let crowdWeight = 0.10
    static let structuralWeight = 0.10
    

    // returns a risk score between 0.0 and 1.0
    static func calculateRisk(for edge: BuildingEdge) -> Double {

        
        let score =
            edge.smokeRisk * smokeWeight +
            edge.heatRisk * heatWeight +
            edge.fireRisk * fireWeight +
            edge.crowdRisk * crowdWeight +
            edge.structuralRisk * structuralWeight
        

        return min(max(score, 0.0), 1.0)
    }
}
