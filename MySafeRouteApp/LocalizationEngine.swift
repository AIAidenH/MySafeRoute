import Foundation


// user location using sensor positions
struct LocalizationEngine
{
    // find nearest sensor
    static func findNearestSensor(
        to userLocation: UserLocation,
        sensors: [SensorNode]
    ) -> SensorNode?
    {
        let sensorsOnSameFloor = sensors.filter
        {
            $0.floor == userLocation.floor
        }


        return sensorsOnSameFloor.min
        {
            sensor1, sensor2 in

            distance(from: userLocation, to: sensor1) <
            distance(from: userLocation, to: sensor2)
        }
    }




    // distance between user and sensor
    private static func distance(
        from userLocation: UserLocation,
        to sensor: SensorNode
    ) -> Double
    {
        let xDifference = userLocation.x - sensor.x
        let yDifference = userLocation.y - sensor.y


        return sqrt(
            xDifference * xDifference +
            yDifference * yDifference
        )
    }
}
