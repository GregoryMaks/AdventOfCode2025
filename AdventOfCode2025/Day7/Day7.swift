import Foundation

// https://adventofcode.com/2025/day/7

class Day7: Day {
    
    let index = 7
    
    let testSet: [String] = {[
        ".......S.......",
        "...............",
        ".......^.......",
        "...............",
        "......^.^......",
        "...............",
        ".....^.^.^.....",
        "...............",
        "....^.^...^....",
        "...............",
        "...^.^...^.^...",
        "...............",
        "..^...^.....^..",
        "...............",
        ".^.^.^.^.^...^.",
        "..............."
    ]}()
    
    func run() {
        part2()
    }
        
    func part1() {
        let rows = testSet//readInput(index)
        var map: [[Int]] = []
        
        let start = rows[0].utf8CString.firstIndex(of: CChar(Character("S").asciiValue!))! as Int
        rows.dropFirst().forEach { row in
            map.append(stringToManifoldsMap(row))
        }
        
        var manifolds = 0
        var beams: [Int] = .init(repeating: 0, count: map[0].count)
        beams[start] = 1
        var nextBeams = beams
        
        for row in 0..<map.count {
            for col in 0..<map[row].count {
                if beams[col] == 1 {
                    if map[row][col] == 1 {
                        manifolds += 1
                        nextBeams[col-1] = 1
                        nextBeams[col+1] = 1
                    } else {
                        nextBeams[col] = 1
                    }
                }
            }
            beams = nextBeams
            nextBeams = .init(repeating: 0, count: map[0].count)
        }
        print("Manifolds: \(manifolds)")
    }
    
    func part2() {
        let rows = readInput(index)
        var map: [[Int]] = []
        
        let start = rows[0].utf8CString.firstIndex(of: CChar(Character("S").asciiValue!))! as Int
        rows.dropFirst().forEach { row in
            map.append(stringToManifoldsMap(row))
        }
        
        var cur: [Int] = .init(repeating: 0, count: map[0].count)
        cur[start] = 1
        var next: [Int] = .init(repeating: 0, count: map[0].count)
        
        for row in 0..<map.count {
            for col in 0..<map[row].count {
                if map[row][col] == 1 {
                    next[col-1] += cur[col]
                    next[col+1] += cur[col]
                } else {
                    next[col] += cur[col]
                }
            }
            cur = next
            next = .init(repeating: 0, count: map[0].count)
        }
        let sum = cur.reduce(0, +)
        print("Permutations: \(sum)  \(Int.max)" )
    }
    
    private func stringToManifoldsMap(_ string: String) -> [Int] {
        return string.utf8CString.dropLast().map { $0 == Character("^").asciiValue! ? 1 : 0 }
    }
    
    private func readRawInput(_ index: Int) -> [String] {
        do {
            return try FileService.readFileAsStrings(at: "input\(index).txt", trim: false)
        } catch {
            print("Error reading file: \(error)")
        }
        return []
    }
}
