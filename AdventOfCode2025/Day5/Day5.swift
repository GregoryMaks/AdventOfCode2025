import Foundation

// https://adventofcode.com/2025/day/5

final class Day5: Day {
    
    let index = 5
    
    let testSet: [String] = {[
        "3-5",
        "10-14",
        "16-20",
        "12-18",
        "",
        "1",
        "5",
        "8",
        "11",
        "17",
        "32"
    ]}()
    
    func run() {
        runPart2()
    }
    
    func runPart1() {
        let rows = readInput(index)
        var ranges: [[UInt64]] = []
        var items: [UInt64] = []
        rows.forEach { row in
            let parts = row.split(separator: "-")
            if parts.count == 2 { ranges.append([UInt64(parts[0])!, UInt64(parts[1])!]) }
            else if parts.count == 1 { items.append(UInt64(parts[0])!) }
        }
        
        var counter = 0
        for item in items {
            for range in ranges {
                if item >= range[0] && item <= range[1] {
                    counter += 1
                    break
                }
            }
        }
        print("Non-spoiled items: \(counter)")
    }
    
    func runPart2() {
        struct Range {
            var s: UInt64
            var e: UInt64
        }
        let rows = readInput(index)
        var ranges: [Range] = []
        rows.forEach { row in
            let parts = row.split(separator: "-")
            if parts.count == 2 { ranges.append(Range(s: UInt64(parts[0])!, e: UInt64(parts[1])!)) }
        }
        
        // O(N*logN)
        ranges.sort(by: { $1.s > $0.s })
        
        var counter: UInt64 = 0
        var r: UInt64 = 0
        
        // O(N)
        for range in ranges {
            var local: UInt64 = 0
            if r < range.s {
                local = range.e - range.s + 1
            } else if r >= range.s && r <= range.e {
                local = range.e - r
            }
            
            r = max(range.e, r)
            
            counter += local
            print("Range: [\(range.s) - \(range.e)] + \(local)  |  R: \(r)")
        }
        
        print(counter)
    }
}
