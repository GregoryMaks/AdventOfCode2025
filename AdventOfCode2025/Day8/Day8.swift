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
//        print(Int.max)
//        print(99999*99999*99999)
        part2()
    }
        
//    func part1_1() {
//        let rows = readInput(index)
//        var sockets: [[Int]] = []
//        for row in rows {
//            sockets.append(row.split(separator: ",").map { Int($0)! })
//        }
//        
//        var pairRoot: Pair? = nil
//        
////        var step = 0
////        var dis: [[Double]] = .init(repeating: .init(repeating: -1, count: sockets.count), count: sockets.count)
//        for i in 0..<sockets.count {
//            for j in i+1..<sockets.count {
//                let dx = sockets[i][0] - sockets[j][0]
//                let dy = sockets[i][1] - sockets[j][1]
//                let dz = sockets[i][2] - sockets[j][2]
//                let pair = Pair(
//                    a: i,
//                    b: j,
//                    dist: sqrt(Double(dx*dx + dy*dy + dz*dz))
//                )
//                
//                // Add to list in ordered fashion
//                if pairRoot == nil { pairRoot = pair }
//                else {
//                    var parent: Pair? = nil
//                    var cur = pairRoot
//                    while true {
//                        if cur == nil { // add to tail
//                            parent?.next = pair
//                            break
//                        }
//                        
//                        if pair.dist < cur!.dist {
//                            if parent == nil { pairRoot = pair }
//                            else { parent?.next = pair }
//                            pair.next = cur
//                            break
//                        } else {
//                            parent = cur
//                            cur = cur!.next
//                        }
//                    }
//                }
//                
////                print(">> Step: \(step)")
////                step += 1
////                var cur = pairRoot
////                while cur != nil {
////                    print(cur!)
////                    cur = cur?.next
////                }
//            }
//        }
//                
////        var cur = pairRoot
////        while cur != nil {
////            print(cur!)
////            cur = cur?.next
////        }
//        
//        // Start connecting to chains
//        // Each group has root
//        
//        var no: Int = 0
//        var groups = Dictionary<Int, Int>() // SocketIdx-Group
//        var sizes: [Int] = []
//        
//        var cur = pairRoot
//        var limit = 1000//10
//        while cur != nil, limit > 0 {
//            let existing: Int? = groups[cur!.a] ?? groups[cur!.b] ?? nil
//            if let existing {
//                groups[cur!.a] = existing
//                groups[cur!.b] = existing
//                sizes[existing] += 1
////                print("Connecting \(testSet[cur!.a]) with \(testSet[cur!.b]) to group \(existing)")
//            } else {
//                groups[cur!.a] = no
//                groups[cur!.b] = no
//                sizes.append(2)
////                print("Connecting \(testSet[cur!.a]) with \(testSet[cur!.b]) to group \(no)")
//                no += 1
//            }
//            
//            cur = cur?.next
//            limit -= 1
//        }
//        
//        print(sizes)
//        
//    }
    
//    func part1_2() {
//        let rows = readInput(index)
//        var sockets: [[Int]] = []
//        for row in rows {
//            sockets.append(row.split(separator: ",").map { Int($0)! })
//        }
//        
//        var pairRoot: Pair? = nil
//        
//        var maxDistance: Double = 0
//        var addedCount = 0
//        
//        for i in 0..<sockets.count {
//            for j in i+1..<sockets.count {
//                let dx = sockets[i][0] - sockets[j][0]
//                let dy = sockets[i][1] - sockets[j][1]
//                let dz = sockets[i][2] - sockets[j][2]
//                let dist = sqrt(Double(dx*dx + dy*dy + dz*dz))
//                
//                if dist > 10000 { continue } // test showed 8010 as max for 1000 pairs
//                
//                // Speeding up
//                if dist >= maxDistance && addedCount >= 1000 {
//                    print("Drop with distance: \(dist), maxDistance: \(maxDistance), addedCount: \(addedCount)")
//                    continue
//                }
//                
//                let pair = Pair(a: i, b: j, dist: dist)
//                
//                // Add to list in ordered fashion
//                if pairRoot == nil { pairRoot = pair }
//                else {
//                    var parent: Pair? = nil
//                    var cur = pairRoot
//                    var curIdx = 0  // need to track list limit
//                    while true {
//                        if cur == nil { // add to tail
//                            parent?.next = pair
//                            
//                            maxDistance = max(maxDistance, pair.dist)
//                            addedCount += 1
//                            print("Added with distance: \(dist), maxDistance: \(maxDistance), addedCount: \(addedCount)")
//                            break
//                        }
//                        
//                        if curIdx > 1000 {
//                            maxDistance = cur!.dist
//                            cur?.next = nil
//                            addedCount = curIdx+1
//                            print("!! Dropping distance: \(dist), dropping tail as idx > 1000")
//                            break
//                        }
//                        
//                        if pair.dist < cur!.dist {
//                            if parent == nil { pairRoot = pair }
//                            else { parent?.next = pair }
//                            pair.next = cur
//                            
//                            maxDistance = max(maxDistance, pair.dist)
//                            addedCount += 1
//                            print("Added with distance: \(dist), maxDistance: \(maxDistance), addedCount: \(addedCount)")
//                            break
//                        } else {
//                            parent = cur
//                            cur = cur!.next
//                        }
//                        
//                        curIdx += 1
//                    }
//                }
//            }
//        }
//        
//        print("Finished | maxDistance: \(maxDistance), addedCount: \(addedCount)")
//        
//        // Start connecting to chains
//        // Each group has root
//        
//        var no: Int = 0
//        var groups = Dictionary<Int, Int>() // SocketIdx-GroupIdx
//        var sizes = Dictionary<Int, Int>() // GroupIdx-Size
//        
//        var cur = pairRoot
//        var limit = 1000//10
//        while cur != nil, limit > 0 {
//            let existingA: Int? = groups[cur!.a]
//            let existingB: Int? = groups[cur!.b]
//            if existingA != nil && existingB != nil {
//                if existingA != existingB { // merge groups
//                    sizes[existingA!]! += sizes[existingB!]!
//                    sizes[existingB!] = 0
//                    var newGroups = groups  // marking all nodes in group B as belonging to group A
//                    groups.forEach { key, value in
//                        if value == existingB {
//                            newGroups[key] = existingA
//                        }
//                    }
//                    groups = newGroups
//                } else { // do nothing as we just closed the circuit
//                }
//            }
//            else if existingA != nil {
//                groups[cur!.b] = existingA!
//                sizes[existingA!] = (sizes[existingA!] ?? 0) + 1
//                //                print("Connecting \(testSet[cur!.a]) with \(testSet[cur!.b]) to group \(existing)")
//            } else if existingB != nil {
//                groups[cur!.a] = existingB!
//                sizes[existingB!] = (sizes[existingB!] ?? 0) + 1
//                //                print("Connecting \(testSet[cur!.a]) with \(testSet[cur!.b]) to group \(existing)")
//            } else {
//                groups[cur!.a] = no
//                groups[cur!.b] = no
//                sizes[no] = 2
//                //                print("Connecting \(testSet[cur!.a]) with \(testSet[cur!.b]) to group \(no)")
//                no += 1
//            }
//            
//            cur = cur?.next
//            limit -= 1
//        }
//        
//        let result = sizes.values.sorted()
//        print(result)
//        print(result.suffix(3).reduce(1, *))
//    }
    
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
        
        // Sort by closest ones
        pairs.sort(by: { $0.dist < $1.dist })
        
        // Start connecting pair to chains of sockets
        var groups = Set<Group>()
        var nodeToGroup = Dictionary<Int, Group>() // Node: Group
        
        // Prefill with single groups containing only one node
        for i in 0..<sockets.count {
            let group = Group(index: i)
            group.nodes.append(i)
            nodeToGroup[i] = group
            groups.insert(group)
        }
        
        // We go for each pair, merging them in groups
        var counter = 0
        for pair in pairs {
            let groupForA = nodeToGroup[pair.a]
            let groupForB = nodeToGroup[pair.b]
            if groupForA != nil && groupForB != nil {
                if groupForA != groupForB { // merge groups, removing B
                    groupForB!.nodes.forEach { nodeToGroup[$0] = groupForA }
                    groupForA?.nodes.append(contentsOf: groupForB!.nodes)
                    groups.remove(groupForB!)
                    
                    if groups.count == 1 {
                        print("Final group merged, counter: \(counter)")
                        print("Nodes: \(sockets[pair.a]) and \(sockets[pair.b])")
                        print("Answer: \(sockets[pair.a][0] * sockets[pair.b][0])")
                        print("Time: \(Date().timeIntervalSince(startTime))")
                        break
                    }
                } else {
                    // do nothing, connected nodes in same group
                }
            }
            else if let groupForA {
                nodeToGroup[pair.b] = groupForA
                groupForA.nodes.append(pair.b)
            } else if let groupForB {
                nodeToGroup[pair.a] = groupForB
                groupForB.nodes.append(pair.a)
            } else {
                assertionFailure()
            }
            
            counter += 1
        }
    }
}

class Group: Hashable {
    let index: Int
    var nodes: [Int] = []
    init(index: Int) { self.index = index }
    func hash(into hasher: inout Hasher) { hasher.combine(index) }
    static func == (lhs: Group, rhs: Group) -> Bool { lhs.index == rhs.index }
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
