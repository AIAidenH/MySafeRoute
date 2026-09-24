import SwiftUI


struct ContentView: View
{
    var connectedSensors: [String]
    {
        SensorNetwork.connectedSensors(
            to: "B",
            connections: sampleSensorConnections
        )
    }




    var body: some View
    {
        VStack(spacing: 20)
        {
            Text("ExitIQ Sensor Network Test")
                .font(.title)
                .fontWeight(.bold)


            Text("Sensor B")


            Text("Connected Sensors: \(connectedSensors.joined(separator: ", "))")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding()
    }
}


#Preview
{
    ContentView()
}
