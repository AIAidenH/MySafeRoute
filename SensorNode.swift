import Foundation


// represents a smart beacon/sensor installed inside the building
struct SensorNode: Identifiable {
    let id: String
    let name: String
    let floor: Int
    

    // position on the building map, measured in meters
    let x: Double
    let y: Double

    
    // current environmental checking
    var temperature: Double
    var smokeLevel: Double
    var fireLevel: Double
    var crowdLevel: Double

    
    // used to track how hazards change over time
    var lastUpdated: Date
}
