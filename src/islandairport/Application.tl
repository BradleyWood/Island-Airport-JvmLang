package islandairport;

import java.lang.Math;

import toylang.Files;
import islandairport.Island;


// This is a port of my island airport calculator from SOFE 3770


fun main(args) {
    var island = loadPoly(args[0]);
    if isError(island) {
        println(island);
    } else {
        println(island.getBounds());
    }
}

fun loadPoly(path) {
    var xpoints = [];
    var ypoints = [];
    var npoints = 0;

    for line : Files.readLines(path) {
        var coords = line.split(" ");
        if coords.size() == 0
            continue;
        if coords.size() != 2 {
            return error("Invalid File Format!");
        }
        xpoints += int(coords[0]);
        ypoints += int(coords[1]);
        npoints += 1;
    }

    if npoints < 3 {
        return error("Island must have 3 or more points!");
    }

    return Island(xpoints, ypoints, npoints);
}
