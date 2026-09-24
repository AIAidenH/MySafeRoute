import Foundation


// sensor network
struct SensorNetwork
{
    // find connected sensors
    static func connectedSensors(
        to sensorID: String,
        connections: [SensorConnection]
    ) -> [String]
    {
        var sensorIDs: [String] = []


        for connection in connections
        {
            if connection.fromSensorID == sensorID
            {
                sensorIDs.append(connection.toSensorID)
            }
            else if connection.toSensorID == sensorID
            {
                sensorIDs.append(connection.fromSensorID)
            }
        }


        return sensorIDs
    }
}
