import Foundation


// sensor reading at specific time
struct SensorReading: Identifiable
{
    let id: String
    let sensorID: String


    // time from start of simulation (second)
    let time: Double


    // environmental readings
    let temperature: Double
    let smokeLevel: Double
    let fireLevel: Double
}
