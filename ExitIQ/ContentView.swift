import SwiftUI


struct ContentView: View
{
    var route: [String]
    {
        RouteEngine.findRoute(
            from: "classroom201",
            to: "exitA",
            building: sampleBuilding
        ) ?? []
    }




    var arrivalTimes: [String: Double]
    {
        RouteEngine.calculateArrivalTimes(
            for: route,
            building: sampleBuilding
        )
    }




    var hazardSpeed: Double
    {
        HazardPrediction.calculateSpeed(
            distance: 8.0,
            firstTime: sensorAReading.time,
            secondTime: sensorBReading.time
        ) ?? 0.0
    }




    var hazardArrivalTime: Double
    {
        HazardPrediction.calculateArrivalTime(
            currentTime: sensorBReading.time,
            distance: 8.0,
            speed: hazardSpeed
        ) ?? 0.0
    }




    var userArrivalTime: Double
    {
        arrivalTimes["hallwayC"] ?? 0.0
    }




    var predictiveRisk: Double
    {
        PredictiveRisk.calculateArrivalRisk(
            userArrivalTime: userArrivalTime,
            hazardArrivalTime: hazardArrivalTime
        )
    }




    var body: some View
    {
        VStack(alignment: .leading, spacing: 20)
        {
            Text("ExitIQ Prediction Test")
                .font(.title)
                .fontWeight(.bold)


            Text("Hallway C")
                .font(.title2)
                .fontWeight(.bold)


            Text(
                "User Arrival: \(userArrivalTime, specifier: "%.1f") sec"
            )


            Text(
                "Hazard Arrival: \(hazardArrivalTime, specifier: "%.1f") sec"
            )


            Text(
                "Predicted Risk: \(predictiveRisk, specifier: "%.2f")"
            )
            .fontWeight(.semibold)
        }
        .padding()
    }
}


#Preview
{
    ContentView()
}
