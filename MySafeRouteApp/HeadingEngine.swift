import Foundation


// relative navigation heading
struct HeadingEngine
{
    // arrow angle from device heading
    static func relativeDirection(
        routeDirection: Double,
        deviceHeading: Double
    ) -> Double
    {
        var angle = routeDirection - deviceHeading


        while angle > 180
        {
            angle -= 360
        }


        while angle < -180
        {
            angle += 360
        }


        // forward alignment zone
        if abs(angle) <= 8
        {
            return 0.0
        }


        return angle
    }
}
