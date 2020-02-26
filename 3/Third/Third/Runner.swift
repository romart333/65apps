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
    
    private let url = "https://api.github.com/users/%@/repos"
    
    private var shouldQuit = false
    
    func run() {
        start()
        startRunLoop()
   }
    
    func start() {
        consoleIO.printUsage()
        let input = consoleIO.getInput()
        if input.caseInsensitiveCompare("quit") == .orderedSame {
            shouldQuit = true
        }
        
        sendRequest(userName: input) { [unowned self] (result, outputType) in
            if outputType != .error {
                self.consoleIO.writeMessage("--> Repositories:")
              
            }
            
            result?.forEach { self.consoleIO.writeMessage($0, to: outputType)}
            self.consoleIO.writeMessage("")
            self.start()
        }
    }
    
    func startRunLoop() {
         while !shouldQuit &&
            RunLoop.current.run(mode: .defaultRunLoopMode, before: Date.distantFuture) {}
    }
    
    func sendRequest(userName: String, completionHandler: @escaping (_ result: [String]?, _ outputType: OutputType) -> ()) {
        if userName.count == 0 {
            start()
            return
        }
        
        let urlWithUser = String(format: url, userName)
        
        AF.request(urlWithUser).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completionHandler(["Empty data response"], .error)
                    return
                }
                    
                if let repos = try? JSONDecoder().decode([Repository].self, from: data) {
                    let repoNames = repos.map {$0.name}
                    completionHandler(repoNames, OutputType.standard)
                } else {
                    completionHandler(["User '\(userName)' was not found"], .error)
                    return
                }
                
                case .failure(let error):
                   completionHandler([error.localizedDescription], .error)
                }
        }
    }
}
