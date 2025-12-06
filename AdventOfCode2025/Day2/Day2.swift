import Foundation

// https://adventofcode.com/2025/day/2

final class Day2: Day {
    
    let index = 2
    
    let testSet1: String = { "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124" }()
    
    /*
     for each number:
     X % 2 = 0
     left part == right part
     */
    
    // Brute force FTW
    func runPart1() {
        let rows = readInput(index)
        assert(rows.count == 1)
        let row = rows[0]
        var count = 0
        var sum = 0
        
        let ranges = row.split(separator: ",")
        for range in ranges {
            let edges = range.split(separator: "-")
            let from = Int(edges[0])!
            let to = Int(edges[1])!
            var num = numToArray(String(edges[0]))
            for i in from...to {
                let inv = isInvalid1(num)
                if inv { print(i) }
                count += inv ? 1 : 0
                sum += inv ? i : 0
                inc(&num)
            }
        }
        print("Count: \(count)  Sum: \(sum)")
    }

    func runPart2() {
        let rows = readInput(index)
        assert(rows.count == 1)
        let row = rows[0]
        var count = 0
        var sum = 0

        let startTime = Date()
        
        let ranges = row.split(separator: ",")
        for range in ranges {
            let edges = range.split(separator: "-")
            let from = Int(edges[0])!
            let to = Int(edges[1])!
            var num = numToArray(String(edges[0]))
            for i in from...to {
                let inv = isInvalid2(num)
//                if inv { print(i) }
                count += inv ? 1 : 0
                sum += inv ? i : 0
                inc(&num)
            }
        }
        print("Time: \(Date().timeIntervalSince(startTime)) | Count: \(count) | Sum: \(sum)")
    }
    
    let num0: Int8 = 48
    
    @inline(__always)
    internal func inc(_ num: inout [Int]) {
        // [9, 5]
        for i in (0..<num.count).reversed() {
            if num[i] == 9 { num[i] = 0; continue }
            else { num[i] += 1; return }
        }
        num.insert(1, at: 0)
    }
    
    @inline(__always)
    private func isInvalid1(_ num: [Int]) -> Bool {
        guard num.count % 2 == 0 else { return false }
        let len = num.count / 2
        for i in 0..<len {
            if num[i] != num[i+len] { return false }
        }
        return true
    }
    
    @inline(__always)
    private func isInvalid2(_ num: [Int]) -> Bool {
        for partLen in 1..<num.count {
            if num.count % partLen != 0 { continue }
            // example count=9, len=3
            var match = true
            let partCount = num.count / partLen
            OUT: for j in 0..<partLen {
                for k in 0..<partCount {
                    if num[j] != num[k * partLen + j] { match = false; break OUT }
                }
            }
        
            if match { return true }
        }
        
        return false
    }
    
    private func numToArray(_ number: String) -> [Int] {
        return number.utf8CString.dropLast().map { Int($0-48) }
    }
}
