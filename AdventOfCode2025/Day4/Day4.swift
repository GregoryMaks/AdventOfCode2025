import Foundation

// https://adventofcode.com/2025/day/4

class Day4 {
    
    let testSet: [String] = {[
        "..@@.@@@@.",
        "@@@.@.@.@@",
        "@@@@@.@.@@",
        "@.@@@@..@.",
        "@@.@@@@.@@",
        ".@@@@@@@.@",
        ".@.@.@.@@@",
        "@.@@@.@@@@",
        ".@@@@@@@@.",
        "@.@.@@@.@."
    ]}()
    
    func run() {
        runPart2()
    }
    
    func runPart1() {
        let rows = readInput()
            .map(stringToArray)
        var accum = 0
        
        let height = rows.count
        let width = rows[0].count
        for y in 0..<height {
            for x in 0..<width {
                if rows[y][x] == 0 { continue }
                    
                var rolls = 0
                OUT: for yy in max(y-1, 0)...min(y+1, height-1) {
                    for xx in max(x-1, 0)...min(x+1, width-1) {
                        if x == xx && y == yy { continue }
                        rolls += rows[yy][xx]
                        if rolls > 3 {
                            break OUT
                        }
                    }
                }
                
                accum += rolls <= 3 ? 1 : 0
            }
        }
        
        print("Movable rolls: \(accum)")
    }

    func runPart2() {
        var rows = readInput()
            .map(stringToArray)
        var modifiedRows = rows
        
        var total = 0
        let height = rows.count
        let width = rows[0].count
        
        let startTime = Date()
        
        var removed = 0
        repeat {
            removed = 0
            for y in 0..<height {
                for x in 0..<width {
                    if rows[y][x] == 0 { continue }
                    
                    var rolls = 0
                    OUT: for yy in max(y-1, 0)...min(y+1, height-1) {
                        for xx in max(x-1, 0)...min(x+1, width-1) {
                            if x == xx && y == yy { continue }
                            
                            rolls += rows[yy][xx]
                            if rolls > 3 {
                                break OUT
                            }
                        }
                    }
                    
                    if rolls <= 3 {
                        modifiedRows[y][x] = 0
                        removed += 1
                    }
                }
            }

            total += removed
            rows = modifiedRows
            
        } while (removed > 0)
        
        print("Time: \(Date().timeIntervalSince(startTime)) Removed rolls: \(total)")
    }
    
    private func stringToArray(_ string: String) -> [Int] {
        return string.utf8CString.dropLast().map { $0 == Character("@").asciiValue! ? 1 : 0 }
    }
}

private extension Day4 {
    
    func readInput() -> [String] {
        do {
            return try FileService.readFileAsStrings(at: "input4.txt")
        } catch {
            print("Error reading file: \(error)")
        }
        return []
    }
}
