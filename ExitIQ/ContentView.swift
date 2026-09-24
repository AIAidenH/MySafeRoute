import SwiftUI


struct ContentView: View
{
    var nearestSensor: SensorNode?
    {
        LocalizationEngine.findNearestSensor(
            to: sampleUserLocation,
            sensors: sampleSensors
        )
    }




    var body: some View
    {
        VStack(spacing: 20)
        {
            Text("ExitIQ Localization Test")
                .font(.title)
                .fontWeight(.bold)


            Text("User Position: (8.0, 10.0)")


            if let sensor = nearestSensor
            {
                Text("Nearest Sensor: \(sensor.id)")
                    .font(.title2)
                    .fontWeight(.semibold)


                Text(sensor.name)
            }
            else
            {
                Text("No Sensor Found")
            }
        }
        .padding()
    }
}


#Preview
{
    ContentView()
}
