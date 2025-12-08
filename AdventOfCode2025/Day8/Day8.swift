import Foundation

// https://adventofcode.com/2025/day/8

class Day8: Day {
    
    let index = 8
    
    let testSet: [String] = {[
        "162,817,812",
        "57,618,57",
        "906,360,560",
        "592,479,940",
        "352,342,300",
        "466,668,158",
        "542,29,236",
        "431,825,988",
        "739,650,466",
        "52,470,668",
        "216,146,977",
        "819,987,18",
        "117,168,530",
        "805,96,715",
        "346,949,466",
        "970,615,88",
        "941,993,340",
        "862,61,35",
        "984,92,344",
        "425,690,689"
    ]}()
    
    func run() {
        part1()
    }
    
    func part1() {
        let startTime = Date()
        
        let rows = readInput(index)
        var sockets: [[Int]] = []
        for row in rows {
            sockets.append(row.split(separator: ",").map { Int($0)! })
        }
        
        var pairs: [Pair] = []
        
        for i in 0..<sockets.count {
            for j in i+1..<sockets.count {
                let dx = sockets[i][0] - sockets[j][0]
                let dy = sockets[i][1] - sockets[j][1]
                let dz = sockets[i][2] - sockets[j][2]
                let pair = Pair(a: i, b: j, dist: dx*dx + dy*dy + dz*dz)
                pairs.append(pair)
            }
        }
        print("Time 1: \(Date().timeIntervalSince(startTime))")
        
        // Sort by closest ones (optimize: min-heap with limit of 1000 items)
        pairs.sort(by: { $0.dist < $1.dist })
        
        print("Time 2: \(Date().timeIntervalSince(startTime))")
        
        // Start connecting pair to chains of sockets
        var jointSet: [Int] = .init(repeating: 0, count: sockets.count)
        
        for i in 0..<jointSet.count {
            jointSet[i] = i
        }
        
        // DisjointSet with Quick Find
        var counter = 0
        for pair in pairs {
            let aRoot = jointSet[pair.a]
            let bRoot = jointSet[pair.b]
            if aRoot != bRoot {
                for i in 0..<jointSet.count {
                    if jointSet[i] == bRoot { jointSet[i] = aRoot }
                }
            }
            counter += 1
            if counter >= 1000 { break }
        }
        
        var groupSizes: [Int] = .init(repeating: 0, count: sockets.count)
        for i in 0..<jointSet.count {
            groupSizes[jointSet[i]] += 1
        }
        
        let result = groupSizes.sorted()
        print(result)
        print(result.suffix(3).reduce(1, *))
        
        print("Time: \(Date().timeIntervalSince(startTime))")
    }
    
    func part2() {
        let startTime = Date()
        
        let rows = readInput(index)
        var sockets: [[Int]] = []
        for row in rows {
            sockets.append(row.split(separator: ",").map { Int($0)! })
        }
        
        var pairs: [Pair] = []
        
        for i in 0..<sockets.count {
            for j in i+1..<sockets.count {
                let dx = sockets[i][0] - sockets[j][0]
                let dy = sockets[i][1] - sockets[j][1]
                let dz = sockets[i][2] - sockets[j][2]
                let pair = Pair(a: i, b: j, dist: dx*dx + dy*dy + dz*dz)
                pairs.append(pair)
            }
        }
        print("Time 1: \(Date().timeIntervalSince(startTime))")
        
        // Sort by closest ones (optimize: min-heap)
        pairs.sort(by: { $0.dist < $1.dist })
        
        print("Time 2: \(Date().timeIntervalSince(startTime))")
        
        // Start connecting pair to chains of sockets
        var jointSet: [Int] = .init(repeating: 0, count: sockets.count)
        
        for i in 0..<jointSet.count {
            jointSet[i] = i
        }
        
        // DisjointSet with Quick Find
        var counter = 0
        var uniqueGroups = sockets.count
        for pair in pairs {
            let aRoot = jointSet[pair.a]
            let bRoot = jointSet[pair.b]
            if aRoot != bRoot {
                for i in 0..<jointSet.count {
                    if jointSet[i] == bRoot { jointSet[i] = aRoot }
                }
                uniqueGroups -= 1
                if uniqueGroups == 1 {
                    print("Final group merged, counter: \(counter)")
                    print("Nodes: \(sockets[pair.a]) and \(sockets[pair.b])")
                    print("Answer: \(sockets[pair.a][0] * sockets[pair.b][0])")
                    print("Time: \(Date().timeIntervalSince(startTime))")
                }
            }
            counter += 1
        }
        
        // Faster alternative, but longer
        
        // Start connecting pair to chains of sockets
//        var groups = Set<Group>()
//        var nodeToGroup: [Group] = [] // Node: Group
//        
//        // Prefill with single groups containing only one node
//        for i in 0..<sockets.count {
//            var group = Group(index: i)
//            group.nodes.append(i)
//            groups.insert(group)
//            nodeToGroup.append(group)
//        }
//        
//        // We go for each pair, merging them in groups
//        var counter = 0
//        for pair in pairs {
//            let groupForA = nodeToGroup[pair.a]
//            let groupForB = nodeToGroup[pair.b]
//            if groupForA.index != groupForB.index {
//                groupForB.nodes.forEach { nodeToGroup[$0] = groupForA }
//                groupForA.nodes.append(contentsOf: groupForB.nodes)
//                groups.remove(groupForB)
//                
//                if groups.count == 1 {
//                    print("Final group merged, counter: \(counter)")
//                    print("Nodes: \(sockets[pair.a]) and \(sockets[pair.b])")
//                    print("Answer: \(sockets[pair.a][0] * sockets[pair.b][0])")
//                    print("Time: \(Date().timeIntervalSince(startTime))")
//                    break
//                }
//            }
//            
//            counter += 1
//        }
    }
}

class Pair: CustomStringConvertible, Hashable {
    let a: Int
    let b: Int
    let dist: Int
    var next: Pair?
    init(a: Int, b: Int, dist: Int, next: Pair? = nil) {
        self.a = a
        self.b = b
        self.dist = dist
        self.next = next
    }
    var description: String { "a:\(a) b:\(b) dist:\(Int(dist))" }
    func hash(into hasher: inout Hasher) {
        hasher.combine(a)
        hasher.combine(b)
    }
    static func == (lhs: Pair, rhs: Pair) -> Bool {
        lhs.a == rhs.a && lhs.b == rhs.b
    }
}
