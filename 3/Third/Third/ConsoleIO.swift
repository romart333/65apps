//
//  ConsoleIO.swift
//  Lesson1
//
//  Created by Roman on 26/09/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

enum OutputType {
    case standard
    case error
}

class ConsoleIO {
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print(message)
        case .error:
            print("Error: \(message)")
        }
    }
    
    func printUsage() {
        writeMessage("Enter user name (or 'quit' to exit): ")        
    }
    
    func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let input = keyboard.availableData
        let strData = String(data: input, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
}
