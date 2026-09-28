import Foundation


enum BuildingNodeType
{
    case room
    case hallway
    case stair
    case exit
    case shelter
}




struct BuildingNode: Identifiable
{
    let id: String
    let name: String
    let floor: Int


    // position on building map
    let x: Double
    let y: Double


    let type: BuildingNodeType
    var sensor: SensorNode?
}
