import Foundation

class FileService {
    
    static func readFileAsStrings(at path: String) throws -> [String] {
        let fileURL = URL(fileURLWithPath: path)
        let contents = try String(contentsOf: fileURL, encoding: .utf8)
        let lines = contents.components(separatedBy: .newlines)
        
        return lines
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
    }
}
