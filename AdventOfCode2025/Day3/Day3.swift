import Foundation

// https://adventofcode.com/2025/day/3

final class Day3: Day {
    
    let index = 3
    
    let num0: Int8 = 48
    
    let testSet1: [String] = {[
        "987654321111111",
        "811111111111119",
        "234234234234278",
        "818181911112111"
    ]}()
    
    func run() {
        runPart2()
    }
    
    func runPart1() {
        let rows = readInput(index)
        var sum: Int = 0
        for row in rows {
            let row = numToArray(row)
            var maxL = 0
            var l = 0
            for i in 0..<row.count-1 {
                if row[i] > maxL {
                    l = i
                    maxL = row[i]
                }
            }
            var maxR = 0
            for i in l+1..<row.count {
                if row[i] > maxR {
                    maxR = row[i]
                }
            }
            
            print("Found: \(maxL)\(maxR)")
            sum += maxL*10 + maxR
        }
        
        print("Sum: \(sum)")
    }

    func runPart2() {
        let rows = readInput(index)
        var result: [Int] = []
        for row in rows {
            let row = numToArray(row)
            var accum: [Int] = []
            
            var maxNum = 0
            var start = 0
            for end in (row.count-12...row.count-1) {
                // we finish at row.count-1-i
                maxNum = 0
                for i in start...end {
                    if row[i] > maxNum {
                        start = i+1
                        maxNum = row[i]
                    }
                }
                accum.append(maxNum)
            }
            result = add(result, accum)
        }
        
        print("Sum: \(result)")
        print("Sum str: \(arrayToString(result))")
    }
    
    private func numToArray(_ number: String) -> [Int] {
        return number.utf8CString.dropLast().map { Int($0-48) }
    }
    
    private func arrayToString(_ arr: [Int]) -> String {
        let chars = arr.map { CChar(Int8($0) + num0) }
        return chars.withUnsafeBufferPointer { ptr in
            return String(validatingCString: ptr.baseAddress!)!
        }
    }
    
    // Long number adding
    private func add(_ a: [Int], _ b: [Int]) -> [Int] {
        var result: [Int] = []
        var carryover = 0
        for i in 0..<max(a.count, b.count) {
            var digit = ((a.count-1 >= i) ? a[a.count-1-i] : 0) + ((b.count-1 >= i) ? b[b.count-1-i] : 0) + carryover
            carryover = digit / 10
            digit = digit % 10
            
            result.insert(digit, at: 0)
        }
        if carryover > 0 {
            result.insert(carryover, at: 0)
        }
        return result
    }
}
