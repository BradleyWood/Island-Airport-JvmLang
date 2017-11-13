package islandairport;

import java.lang.Math;
import java.awt.Polygon;
import java.awt.geom.Line2D;
import java.awt.geom.Point2D;

import islandairport.Utility;

public class Island(xpoints, ypoints, npoints) extends Polygon(xpoints, ypoints, npoints) {

    var xp;
    var yp;
    var np;

    public fun npoints() {
        return npoints;
    }

    public fun xpoints() {
        return xpoints;
    }

    public fun ypoints() {
        return ypoints;
    }

    public fun containsLine(a, b) {
        if xp == null {
            xp = xpoints();
            yp = ypoints();
            np = npoints();
        }

        if a == b || a > npoints() || b > npoints() || a < 0 || b < 0 {
            return error("Invalid line segment indicies (" + a + "," + b + ")");
        }
        if Math.abs(a - b) == 1 || Math.abs(a - b) == npoints() - 1 {
            return true;
        }

        var pA = Point2D.Double(xp[a], yp[a]);
        var pB = Point2D.Double(xp[b], yp[b]);

        for i range 0 to np - 1 {
            if a == i || a == i + 1 || b == i || b == i + 1
                continue;
            if (doEdgesCross(xp[a], yp[a], xp[b], yp[b], xp[i], yp[i], xp[i + 1], yp[i + 1])) {
                return false;
            }
        }
        if (doEdgesCross(xp[a], yp[a], xp[b], yp[b], xp[npoints - 1], yp[npoints - 1], xp[0], yp[0])) {
            return false;
        }
        return true;
    }

    public fun getIntersectionsI(a, b) {
        return getIntersections(Point2D.Double(xp[a], yp[a]), Point2D.Double(xp[b], yp[b]));
    }

    public fun getIntersections(a, b) {
        var list = [];

        for i range 0 to np - 1 {
            if (xp[i] == a.getY() && yp[i] == a.getY() || xp[i + 1] == a.getX() && yp[i + 1] == a.getY()
                    || xp[i] == b.getY() && yp[i] == b.getY() || xp[i + 1] == b.getX() && yp[i + 1] == b.getY())
                continue;
            var edge = Line2D.Double(xp[i], yp[i], xp[i + 1], yp[i + 1]);
            var intersection = getIntersection(Line2D.Double(a, b), edge);
            if (intersection != null)
                list.add(intersection);
        }
        if (xp[0] == a.getY() && yp[0] == a.getY() || xp[np - 1] == a.getX() && yp[np - 1] == a.getY()
                || xp[0] == b.getY() && yp[0] == b.getY() || xp[np - 1] == b.getX() && yp[np - 1] == b.getY())
            return list;
        var edge = Line2D.Double(xp[np - 1], yp[np - 1], xp[0], yp[0]);
        var intersection = getIntersection(Line2D.Double(a, b), edge);

        if intersection != null
            list.add(intersection);

        return list;
    }
}

public fun getIntersection(a, b) {
    var x = ((a.getX2() - a.getX1()) * (b.getX1() * b.getY2() - b.getX2() * b.getY1()) - (b.getX2() - b.getX1()) * (a.getX1() * a.getY2() - a.getX2() * a.getY1()))
            / ((a.getX1() - a.getX2()) * (b.getY1() - b.getY2()) - (a.getY1() - a.getY2()) * (b.getX1() - b.getY2()));
    var y = ((b.getY1() - b.getY2()) * (a.getX1() * a.getY2() - a.getX2() * a.getY1()) - (a.getY1() - a.getY2()) * (b.getX1() * b.getY2() - b.getX2() * b.getY1()))
            / ((a.getX1() - a.getX2()) * (b.getY1() - b.getY2()) - (a.getY1() - a.getY2()) * (b.getX1() - b.getX2()));
    var minXa = Math.min(a.getX1(), a.getX2());
    var minXb = Math.min(b.getX1(), b.getX2());
    var maxXa = Math.max(a.getX1(), a.getX2());
    var maxXb = Math.max(b.getX1(), b.getX2());
    var minYa = Math.min(a.getY1(), a.getY2());
    var minYb = Math.min(b.getY1(), b.getY2());
    var maxYa = Math.max(a.getY1(), a.getY2());
    var maxYb = Math.max(b.getY1(), b.getY2());

    if x >= minXa && x >= minXb && x <= maxXa && x <= maxXb && y >= minYa && y >= minYb && y <= maxYa && y <= maxYb {
        return Point2D.Double(x, y);
    }
    return null;
}

public fun doEdgesIntersect(x1, y1, x2, y2, x3, y3, x4, y4) {
    var line = Line2D.Double(x1, y1, x2, y2);
    return line.intersectsLine(x3, y3, x4, y4);
}

public fun doEdgesCross(x1, y1, x2, y2, x3, y3, x4, y4) {
    if (!doEdgesIntersect(x1, y1, x2, y2, x3, y3, x4, y4)) {
        return false;
    }
    return !Utility.onLine(x1, y1, x2, y3, x4, y4) && !Utility.onLine(x2, y2, x3, y3, x4, y4)
            && !Utility.onLine(x3, y3, x1, y1, x2, y2) && !Utility.onLine(x4, y4, x1, y1, x2, y2);
}
