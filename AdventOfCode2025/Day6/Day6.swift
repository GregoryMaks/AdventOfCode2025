import Foundation

// https://adventofcode.com/2025/day/6

class Day6: Day {
    
    let index = 6
    let num0: CChar = 48
    
    let testSet: [String] = {[
        "123 328  51 64 ",
        " 45 64  387 23 ",
        "  6 98  215 314",
        "*   +   *   +  "
    ]}()
    
    func run() {
        part2()
    }
        
    func part1() {
        let rows = readInput(index)
        var nums: [[UInt64]] = []
        var ops: [String] = []
        
        rows.forEach { row in
            if row.hasPrefix("+") || row.hasPrefix("*") {
                ops = row.split(separator: " ").map(String.init)
            } else {
                nums.append(row.split(separator: " ").map{ UInt64($0)! })
            }
        }
        
        var total: UInt64 = 0
        for col in 0..<nums[0].count {
            var result: UInt64 = nums[0][col]
            for row in 1..<nums.count {
                result = ops[col] == "+" ? (result + nums[row][col]) : (result * nums[row][col])
            }
            total += result
        }
        print(total)
    }
    
    func part2() {
        let input = readRawInput(index)
        let rows = input.map { $0.utf8CString.dropLast() }
        
        var total: UInt64 = 0
        var block: UInt64 = 0
        
        var op = -1  // 0 +, 1 *
        for col in 0..<rows[0].count {
            switch UInt8(rows.last![col]) {
            case Character("+").asciiValue!: op = 0
            case Character("*").asciiValue!: op = 1
            default: break
            }
            assert(op != -1)
            
            
            var accum: UInt64 = 0
            var multiplier: UInt64 = 1
            for row in (0..<rows.count-1).reversed() {
                let num = rows[row][col] == 32 ? 0 : UInt64(rows[row][col] - num0)
                if num > 0 {
                    accum += num * multiplier
                    multiplier *= 10
                }
            }
            
            if accum == 0 {
                total += block
                block = 0
                op = -1
            } else {
                block = (block == 0) ? accum : (op == 0 ? (block + accum) : (block * accum))
            }
        }
        total += block
        
        print(total)
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
