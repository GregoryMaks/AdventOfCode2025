import Foundation

// https://adventofcode.com/2025/day/9

class Day9: Day {
    
    let index = 9
    
    let testSet: [String] = {[
        "7,1",
        "11,1",
        "11,7",
        "9,7",
        "9,5",
        "2,5",
        "2,3",
        "7,3"
    ]}()
    
    func run() {
        part1()
    }
    
    func part1() {
        let startTime = Date()
        
        let rows = readInput(index)
        let pts: [[Int]] = rows.map { $0.split(separator: ",").map { Int($0)! } }
        
        var maxSquare = 0
        for pt1 in pts {
            for pt2 in pts {
                maxSquare = max(maxSquare, (abs(pt1[0]-pt2[0])+1)*(abs(pt1[1]-pt2[1])+1))
            }
        }
        
        print("MaxSquare: \(maxSquare)")    //4729332959
        print("Time: \(Date().timeIntervalSince(startTime))")
    }
    
    func part2() {
        var startTime = Date()
        
        let rows = readInput(index)
        let pts: [[Int]] = rows.map { $0.split(separator: ",").map { Int($0)! } }
     
        print("Read points: \(Date().timeIntervalSince(startTime))")
        startTime = Date()
        
        var lines: [[(Int, Int)]] = []
        var prev = pts.last!
        for i in 0..<pts.count {
            let a = (prev[0], prev[1])
            let b = (pts[i][0], pts[i][1])
            lines.append([a, b])
            prev = pts[i]
        }
        
        print("Lines ready: \(Date().timeIntervalSince(startTime))")
        startTime = Date()
        
        func lineIntersectsRect(
            x1: Int, y1: Int, x2: Int, y2: Int,
            rx1: Int, ry1: Int, rx2: Int, ry2: Int
        ) -> Bool {
            let (rMinX, rMaxX, rMinY, rMaxY) = (min(rx1, rx2), max(rx1, rx2), min(ry1, ry2), max(ry1, ry2))
            
            if y1 == y2 {
                return rMinY < y1 && y1 < rMaxY && min(x1, x2) < rMaxX && rMinX < max(x1, x2)
            } else if x1 == x2 {
                return rMinX < x1 && x1 < rMaxX && min(y1, y2) < rMaxY && rMinY < max(y1, y2)
            }
            
            fatalError()
        }
        
        // Longest lines are most probable to hit
        lines.sort { l, r in
            let llen = (l[0].0-l[1].0)*(l[0].0-l[1].0) + (l[0].1-l[1].1)*(l[0].1-l[1].1)
            let rlen = (r[0].0-r[1].0)*(r[0].0-r[1].0) + (r[0].1-r[1].1)*(r[0].1-r[1].1)
            return llen < rlen
        }
        lines.reverse()
        
        print("Lines sorted: \(Date().timeIntervalSince(startTime))")
        startTime = Date()
        
        var maxSquare = 0
        for pt1 in pts {
            for pt2 in pts {
                let sq = (abs(pt1[0]-pt2[0])+1) * (abs(pt1[1]-pt2[1])+1)
                if sq > maxSquare {
                    var inter = false
                    for line in lines {
                        inter = lineIntersectsRect(
                            x1: line[0].0, y1: line[0].1,
                            x2: line[1].0, y2: line[1].1,
                            rx1: pt1[0], ry1: pt1[1],
                            rx2: pt2[0], ry2: pt2[1]
                        )
                        if inter {
                            break
                        }
                    }
                    
                    if !inter {
                        maxSquare = sq
                        print("Found: \(sq) | \(pt1[0]):\(pt1[1]) | \(pt2[0]):\(pt2[1])")
                    }
                }
            }
        }
        
        print("MaxSquare: \(maxSquare)")
        print("Time: \(Date().timeIntervalSince(startTime))")
    }
}
