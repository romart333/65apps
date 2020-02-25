//
//  Runner.swift
//  Lesson1
//
//  Created by Roman on 30/09/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation
import Alamofire

class Runner {
    
    private let consoleIO = ConsoleIO()
    // пока что хардкод
    private let url = "https://api.github.com/users/romart333/repos"
    
    private enum OptionType: String{
        case show = "s"
        case quit = "q"
        case unknown
        
        init(_ value: String) {
            switch value {
            case "s": self = .show
            case "q": self = .quit
            default:  self = .unknown
            }
        }
    }
    
    private func getOption(_ option: String) -> (option: OptionType, value: String) {
        
        return (OptionType(option), option)
    }
    
    func run() {
        
        var shouldQuit = false
        while(!shouldQuit) {
            consoleIO.printUsage()
            let (option, value) = getOption(consoleIO.getInput())
            
            switch option {
            case .show:
                consoleIO.writeMessage("Enter user name:")
//                let userName = consoleIO.getInput()
                self.consoleIO.writeMessage("Start response... ")
                
                AF.request(url).responseJSON { [unowned self] response in
                    self.consoleIO.writeMessage("Inside response")
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            self.consoleIO.writeMessage("Empty data response",to: .error)
                            break
                        }
                            
                        if let repos = try? JSONDecoder().decode([Repository].self, from: data) {
                            for repo in repos {
                                self.consoleIO.writeMessage("\(repo.name)")
                            }
                        } else {
                            self.consoleIO.writeMessage("JSON data was not parsed",to: .error)
                        }
                        
                        case .failure(let error):
                            self.consoleIO.writeMessage(error.localizedDescription, to: .error)
                        }
                }
                consoleIO.writeMessage("End response.")
            case .quit:
                shouldQuit = true
                
            default:
                consoleIO.writeMessage("Unknow command '\(value)'", to: .error)
            }
            
        }
   }
    
}
