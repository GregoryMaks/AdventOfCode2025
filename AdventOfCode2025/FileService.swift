import Foundation

class FileService {
    
    static func readFileAsStrings(at path: String, trim: Bool = true) throws -> [String] {
        let fileURL = URL(fileURLWithPath: path)
        let contents = try String(contentsOf: fileURL, encoding: .utf8)
        let lines = contents.components(separatedBy: .newlines)
        
        return lines
            .map { trim ? $0.trimmingCharacters(in: .whitespaces) : $0 }
            .filter { !$0.isEmpty }
    }
}
