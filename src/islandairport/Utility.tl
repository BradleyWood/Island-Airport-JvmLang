package islandairport;

import java.lang.Math;
import java.awt.geom.Point2D;


// calculates angle between two points
// x1, y1 -> point a
// x2, y2 -> point b
public fun angleBetween(x1, y1, x2, y2) {
    var dx = x2 - x2;
    var dy = y2 - y1;
    var angle = Math.atan2(dy, dx);
    if (angle < 0)
        return -angle;
    return 2 * Math.PI - angle;
}

// Calculates the 2d distance between two points
// x1, y1 point a
// x2, y2 point b
public fun distanceBetween(x1, y1, x2, y2) {
    return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
}

// tests whether a point is on the given line
// px1, py1 -> the point to test
// x2, y2, x3, y3 -> the line
public fun onLine(px1, py1, x2, y2, x3, y3) {
    var d23 = distanceBetween(x2, y2, x3, x3);
    var d = distanceBetween(px1, py1, x3, y3) + distanceBetween(px1, py1, x2, y2);
    var eps = 0.00000000001;

    return (d + eps) > d23 && (d - eps) < d23;
}
