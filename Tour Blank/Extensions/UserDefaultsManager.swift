//
//  UserDefaultsManager.swift
//
//  Created by Nurillo Domlajonov on 11/08/23.
//

import UIKit
import UnsplashPhotoPicker

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
    
    //MARK: mapvc
    func savePlaces(items: [String]){
        UserDefaults.standard.set(items, forKey: "savedPlaces")
    }
    
    func saveLatitude(items: [Double]){
        UserDefaults.standard.set(items, forKey: "latitude")
    }
    
    func saveLongtitude(items: [Double]){
        UserDefaults.standard.set(items, forKey: "longtitude")
    }
    
    
    //MARK: tripPlanvc
    func saveCountry(items: [String]){
        UserDefaults.standard.set(items, forKey: "savedCountry")
    }
    
    func saveCities(items: [String]){
        UserDefaults.standard.set(items, forKey: "savedCities")
    }
    
    func saveDate(items: [String]){
        UserDefaults.standard.set(items, forKey: "savedDate")
    }
    
    func saveScheduleTime(items: [String]){
        UserDefaults.standard.set(items, forKey: "scheduleTime")
    }
    
    func saveScheduleTitle(items: [String]){
        UserDefaults.standard.set(items, forKey: "scheduleTitle")
    }
    
    func saveImages(items: [String]){
        UserDefaults.standard.set(items, forKey: "imageUrls")
    }
    
    func loadImages() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "imageUrls")  as? [String] ?? [String]()
        return array
    }
    
    func saveSightSee(items: [String]){
        UserDefaults.standard.set(items, forKey: "sightsee")
    }
    
    func loadSightSee() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "sightsee")  as? [String] ?? [String]()
        return array
    }
    
    func saveImpression(items: [String]){
        UserDefaults.standard.set(items, forKey: "impression")
    }
    
    func loadImpression() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "impression")  as? [String] ?? [String]()
        return array
    }
    func saveRateAmount(items: [Double]){
        UserDefaults.standard.set(items, forKey: "RateAmount")
    }
    
    func loadRateAmount() -> [Double] {
        let array =  UserDefaults.standard.array(forKey: "RateAmount")  as? [Double] ?? [Double]()
        return array
    }
    //MARK: GET
    func loadScheduleTime() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "scheduleTime") as? [String] ?? [String]()
        return array
    }
    
    func loadScheduleTitle() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "scheduleTitle") as? [String] ?? [String]()
        return array
    }
    //tripplanvc
    func loadCountry() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "savedCountry") as? [String] ?? [String]()
        return array
    }
    
    func loadCities() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "savedCities") as? [String] ?? [String]()
        return array
    }
    
    
    func loadDate() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "savedDate") as? [String] ?? [String]()
        return array
    }
    
    //mapvc
    func loadPlaces() -> [String] {
        let array =  UserDefaults.standard.array(forKey: "savedPlaces") as? [String] ?? [String]()
        return array
    }
    
    func loadLatitude() -> [Double] {
        let array =  UserDefaults.standard.array(forKey: "latitude") as? [Double] ?? [Double]()
        return array
    }
    
    func loadLongtitude() -> [Double] {
        let array =  UserDefaults.standard.array(forKey: "longtitude") as? [Double] ?? [Double]()
        return array
    }
    
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
