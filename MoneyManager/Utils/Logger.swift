//
// Created by hulkdx on 09/12/2018
//


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
}
