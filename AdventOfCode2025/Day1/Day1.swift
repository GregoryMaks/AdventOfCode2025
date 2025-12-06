
// https://adventofcode.com/2025/day/1

final class Day1: Day {
    
    let index = 1
    
    let testSet1: [String] = {[
        "L68",
        "L30",
        "R48",
        "L5",
        "R60",
        "L55",
        "L1",
        "L99",
        "R14",
        "L82"
    ]}()
    
    let testSet2: [String] = {[
        "L50",
        "R50"
    ]}()
    
    //  / 50 \
    // 25    75
    //  \0 99/
    
    // Count times we stop at 0
    func runPart1() {
        let codes = readInput(index)
        
        var r = 0
        var pos: Int = 50
        for code in codes {
            let dir = code.first! == "R"    // 0 left, 1 right
            let clicks = Int(code.dropFirst())! % 100
            pos += (dir ? clicks : -clicks) % 100
            if pos >= 100 { pos -= 100 }
            if pos < 0 { pos = 100 + pos }
                
            r += (pos == 0) ? 1 : 0
        }
        print(r)
    }
    
    // Count times we stop and pass 0
    func runPart2() {
        let codes = readInput(index)//testSet
        
        var r = 0
        var pos: Int = 50
        for code in codes {
            let dir = code.first! == "R" ? 1 : -1
            var clicks = Int(code.dropFirst())!
            
            let prevR = r
            var debug = "from: \(pos) | \(code) |"
            
            // Doesn't matter what direction every full turn is one click
            r += clicks / 100
            clicks = clicks % 100
            
            if clicks > 0 {
                var to = pos + dir * clicks
                if to >= 100 {
                    r += 1
                    to -= 100
                } else if to <= 0 {
                    if pos > 0 { r += 1 }   // if we start from 0 there is no additional click
                    if to != 0 { to += 100 }    // we don't need to turn 0 to 100, but we need to turn -1 to 99
                }
                pos = to
            }
            debug += " to: \(pos) | clicks: \(r-prevR)"
            print(debug)
        }
        print(r)
    }
}
