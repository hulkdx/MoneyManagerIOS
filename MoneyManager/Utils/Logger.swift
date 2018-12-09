//
// Created by hulkdx on 09/12/2018
//
import Foundation

public class Logger {
    static func log(_ msg:        String,
                    functionName: String = #function,
                    fileName:     String = #file,
                    lineNumber:   Int    = #line)
    {
        
        var className = fileName
        if var index1 = fileName.lastIndex(of: "/"), let index2 = fileName.lastIndex(of: ".") {
            index1 = fileName.index(after: index1)
            className = String(fileName[index1..<index2])
        }
        
        print("\(className):\(functionName):\(lineNumber):  \(msg)")
    }
    
    static func getPreviousFunctionName() -> String {
        var result = #function
        do {
            let str = Thread.callStackSymbols[2]
            let regex = try! NSRegularExpression(pattern: "(C\\d+[^yyF]+)")
            if let match = regex.firstMatch(in: str, options: [], range: NSRange(location: 0, length: str.count)) {
                result = String(str[Range(match.range, in: str)!])
            }
        }
        return result
    }
}
