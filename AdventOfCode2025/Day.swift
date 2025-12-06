class Day {
    func readInput(_ index: Int) -> [String] {
        do {
            return try FileService.readFileAsStrings(at: "input\(index).txt")
        } catch {
            print("Error reading file: \(error)")
        }
        return []
    }
}
