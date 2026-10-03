# ExitIQ

ExitIQ is an iOS emergency navigation prototype that finds a safer route through a building when conditions change.

I started this project because normal evacuation maps show fixed routes. During an actual emergency, however, smoke, fire, or a blocked hallway could make that route unsafe.

ExitIQ is an attempt to make the evacuation route change with the situation.


---


## How It Works

The building is represented as a graph made of rooms, hallways, stairs, exits, and refuge areas.

Each path can have different risk values, including:

- Smoke
- Heat
- Fire
- Crowd level
- Structural risk

ExitIQ checks the available routes and avoids routes that become too dangerous.

If there are multiple usable exits, it chooses the nearest usable exit. If all exit routes become unsafe, it can guide the user to a refuge area instead.


---


## Demo Modes

The current prototype has three conditions that can be tested.

### Normal

ExitIQ finds a usable exit and gives the user directions to it.

### Hazard

The Hazard button simulates a dangerous condition on part of the building.

ExitIQ checks the routes again and redirects the user to another exit if the original route is no longer usable.

### Critical

The Critical button simulates a situation where the exit routes are unsafe.

In this case, ExitIQ directs the user to the refuge area.


---


## Navigation

The app shows:

- Current location
- Next location
- Direction to travel
- Distance to the next location
- Total remaining distance
- Current route status

The large navigation arrow also uses the iPhone's heading so it changes as the user turns the phone.


---


## Evacuation Map

The map shows the building paths, current location, exits, refuge area, hazards, and the selected route.

The route on the map changes when the simulated emergency condition changes.


---


## Hazard Prediction

I also created a basic hazard prediction model using simulated sensor readings.

The program can compare sensor readings over time to estimate the direction and speed of a moving hazard and calculate when it could reach another sensor.

This is currently a simulation and is not a real fire prediction system.


---


## Built With

- Swift
- SwiftUI
- Xcode
- Core Location
- Graph-based routing
- Simulated sensor data


---


## Future Plans

Some things I would like to add in the future are:

- Real Bluetooth beacon testing
- Environmental sensors
- More accurate indoor positioning
- Multi-floor buildings
- Larger building maps
- Live sensor data
- Improved hazard prediction


---


## Important

ExitIQ is currently a prototype using simulated emergency data.

It is not designed or tested for use during a real emergency.
