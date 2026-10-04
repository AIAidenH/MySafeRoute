import Foundation


// sample sensor data used for the MySafeRouteApp simulation
let sensorA = SensorNode(
    id: "A",
    name: "East Hallway A",
    floor: 2,
    x: 6.0,
    y: 10.0,
    temperature: 22.0,
    smokeLevel: 0.02,
    fireLevel: 0.0,
    crowdLevel: 0.20,
    lastUpdated: Date()
)


let sensorB = SensorNode(
    id: "B",
    name: "East Hallway B",
    floor: 2,
    x: 14.0,
    y: 10.0,
    temperature: 34.0,
    smokeLevel: 0.18,
    fireLevel: 0.05,
    crowdLevel: 0.25,
    lastUpdated: Date()
)


let sensorC = SensorNode(
    id: "C",
    name: "East Hallway C",
    floor: 2,
    x: 22.0,
    y: 10.0,
    temperature: 57.0,
    smokeLevel: 0.61,
    fireLevel: 0.40,
    crowdLevel: 0.30,
    lastUpdated: Date()
)


// sensors used in simulation
let sampleSensors = [
    sensorA,
    sensorB,
    sensorC
]


// sample user location
var sampleUserLocation = UserLocation(
    floor: 2,
    x: 8.0,
    y: 10.0,
    nearestSensorID: nil
)




// sensor network
let sampleSensorConnections = [
    SensorConnection(
        id: "A-B",
        fromSensorID: "A",
        toSensorID: "B",
        distance: 8.0
    ),

    SensorConnection(
        id: "B-C",
        fromSensorID: "B",
        toSensorID: "C",
        distance: 8.0
    )
]




// hazard detection data
let sensorAReading = SensorReading(
    id: "A-1",
    sensorID: "A",
    time: 10.0,
    temperature: 45.0,
    smokeLevel: 0.40,
    fireLevel: 0.20
)


let sensorBReading = SensorReading(
    id: "B-1",
    sensorID: "B",
    time: 30.0,
    temperature: 50.0,
    smokeLevel: 0.55,
    fireLevel: 0.30
)
