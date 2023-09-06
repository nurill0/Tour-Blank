//
//  UserDefaultsManager.swift
//
//  Created by Nurillo Domlajonov on 11/08/23.
//

import Foundation


class UserDefaultsManager{
    
    static let shared = UserDefaultsManager()
    let defaults = UserDefaults.standard
    
    func setInstruction(isOpened: Bool){
        defaults.set(isOpened, forKey: "instruction")
    }
    
    func setNickname(isOpened: Bool){
        defaults.set(isOpened, forKey: "nick")
    }
    
    func setNick(name: String){
        defaults.set(name, forKey: "name")
    }
    //MARK: GET
    
    func getInstruction()->Bool{
        defaults.bool(forKey: "instruction")
    }
    
    func getNickname()->Bool{
        defaults.bool(forKey: "nick")
    }
    
    func getNick()->String{
        defaults.string(forKey: "name") ?? "unknown"
    }
    
    

  
}
