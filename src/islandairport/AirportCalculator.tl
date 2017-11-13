package islandairport;

import java.lang.Math;
import java.lang.Double;

import java.awt.geom.Point2D;
import java.awt.geom.Line2D;

import islandairport.Utility;

public class AirportCalculator(island) {

    public fun calculate() {
        var xpoints = island.xpoints();
        var ypoints = island.ypoints();

        var maxLength = Double.NEGATIVE_INFINITY;
        var start = null;
        var end = null;

        var c = 0;
        for a range 0 to island.npoints() {
            for b range a + 1 to island.npoints() {
                if island.containsLine(a, b) {
                    var pointA = extend(Point2D.Double(xpoints[a], ypoints[a]), Point2D.Double(xpoints[b], ypoints[b]), true);
                    var pointB = extend(Point2D.Double(xpoints[a], ypoints[a]), Point2D.Double(xpoints[b], ypoints[b]), false);

                    var dist = pointA.distance(pointB);

                    if dist > maxLength {
                        maxLength = dist;
                        start = pointA;
                        end = pointB;
                    }
                }
            }
        }

        if start != null {
            return Line2D.Double(start, end);
        }
    }

    private fun extend(a, b, extendA) {
        var bounds = island.getBounds();
        var extensionAmount = bounds.getWidth() * bounds.getHeight();
        var nx = 0;
        var ny = 0;
        if extendA {
            var angle = Utility.angleBetween(b, a);
            nx = a.getX() + extensionAmount * Math.cos(angle);
            ny = a.getY() + extensionAmount * Math.sin(angle);
        } else {
            var angle = Utility.angleBetween(a, b);
            nx = b.getX() + extensionAmount * Math.cos(angle);
            ny = b.getY() + extensionAmount * Math.sin(angle);
        }
        var o = b;
        if extendA
            o = a;
        var newPoint = getClosestIntersection(Point2D.Double(nx, ny), o);

        if newPoint != null {
            var m1 = (b.getX() + newPoint.getX()) / 2.0;
            var m2 = (b.getY() + newPoint.getY()) / 2.0;
            if extendA {
                m1 = (a.getX() + newPoint.getX()) / 2.0;
                m2 = (a.getY() + newPoint.getY()) / 2.0;
            }
            if !island.contains(m1, m2) {
                if extendA
                    return a;
                return b;
            }
            return newPoint;
        }
        if extendA
            return a;
        return b;
    }

    private fun getClosestIntersection(a, b) {
        var dist = Double.POSITIVE_INFINITY;
        var result = null;

        var intersections = island.getIntersections(a, b);
        for pt : intersections {
            if (pt.distance(b) < dist && dist > 0.0000001) {
                result = pt;
                dist = pt.distance(b);
            }
        }

        return result;
    }
}
