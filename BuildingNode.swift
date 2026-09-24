import Foundation


// defines the type of location inside the building
enum BuildingNodeType {
    case room
    case hallway
    case stair
    case exit
    case shelter
}


// represents a physical location in the building
struct BuildingNode: Identifiable {
    let id: String
    let name: String
    let floor: Int
    let type: BuildingNodeType

    
    // optional sensor installed near this location
    var sensor: SensorNode?
}
