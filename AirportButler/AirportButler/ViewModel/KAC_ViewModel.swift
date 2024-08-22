//
//  KAC_ViewModel.swift
//  AirportButler
//
//  Created by lee eunsoo on 8/12/24.
//

import Foundation

class KAC_Time_ViewModel: ObservableObject {
    @Published var waitTimes: [KAC_Time_Model] = []
    
    //소요시간 불러오기 url
    private var urlString:String = ""

    
    var iataCode: String = "nil"
    
    init(_ iataCode: String) {
        
        switch iataCode {
        case "김포공항":
            self.iataCode = "GMP"
        case "김해공항":
            self.iataCode = "PUS"
        case "제주공항":
            self.iataCode = "CJU"
        case "청주공항":
            self.iataCode = "CJJ"
        case "대구공항":
            self.iataCode = "TAE"
        default:
            self.iataCode = "PUS"
        }
        
        urlString="https://api.odcloud.kr/api/getAPRTWaitTime_v2/v1/aprtWaitTimeV2?page=1&perPage=10&returnType=JSON&cond%5BIATA_APCD%3A%3AEQ%5D=\(self.iataCode)&serviceKey=nnByrN0KJ1dbbHuo3E9UCOBBBQqwHKGmbcEjwd%2FuylRy0nuLOJwlP0LXkclyELieIpiV%2BbngWn%2FxkXoQnmYcvQ%3D%3D"
    }
    
    func fetchWaitTimes() {
        guard let url = URL(string: urlString) else { return }
        
//        print(urlString)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(KAC_Time_Model_ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self.waitTimes = apiResponse.data
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        }.resume()
        
        
        
    }
}
class KAC_Level_ViewModel: ObservableObject{
    @Published var waitLevels: [KAC_Level_Model] = []
    @Published var airportName:String = "김해공항"

    
    var iataCode: String = "PUS"
    private var urlString = ""
    
    init(_ iataCode: String = "PUS") {
        self.iataCode = iataCode
        self.urlString = "https://api.odcloud.kr/api/getAPRTPsgrCongestion_v2/v1/aprtPsgrCongestion​V2?page=1&perPage=10&returnType=JSON&cond%5BIATA_APCD%3A%3AEQ%5D="+self.iataCode+"&serviceKey=nnByrN0KJ1dbbHuo3E9UCOBBBQqwHKGmbcEjwd%2FuylRy0nuLOJwlP0LXkclyELieIpiV%2BbngWn%2FxkXoQnmYcvQ%3D%3D"
    }
    
    
    
    func fetchWaitLevel() {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(KAC_Level_Model_ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self.waitLevels = apiResponse.data
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}

class KAC_ViewModel: ObservableObject{
    @Published var waitLevels: [KAC_Level_Model] = []
    @Published var waitTimes: [KAC_Time_Model] = []
    @Published var airportName:String = "김해공항"
    
    var iata: String = ""
    var timeURL: String = ""
    var levelURL: String = ""
    
    
    init( iataCode:String, airportName:String){
        self.iata = iataCode
    
        switch self.airportName {
        case "김해공항":
            self.iata = "PUS"
        case "김포공항":
            self.iata = "GMP"
        case "제주공항":
            self.iata = "CJU"
        case "대구공항":
            self.iata = "TAE"
        default:
            self.iata = "PUS"
        }
        
        timeURL = "https://api.odcloud.kr/api/getAPRTWaitTime_v2/v1/aprtWaitTimeV2?page=1&perPage=10&returnType=JSON&cond%5BIATA_APCD%3A%3AEQ%5D="+self.iata+"&serviceKey=nnByrN0KJ1dbbHuo3E9UCOBBBQqwHKGmbcEjwd%2FuylRy0nuLOJwlP0LXkclyELieIpiV%2BbngWn%2FxkXoQnmYcvQ%3D%3D"
        
        levelURL = "https://api.odcloud.kr/api/getAPRTPsgrCongestion_v2/v1/aprtPsgrCongestion​V2?page=1&perPage=10&returnType=JSON&cond%5BIATA_APCD%3A%3AEQ%5D="+self.iata+"&serviceKey=nnByrN0KJ1dbbHuo3E9UCOBBBQqwHKGmbcEjwd%2FuylRy0nuLOJwlP0LXkclyELieIpiV%2BbngWn%2FxkXoQnmYcvQ%3D%3D"
        
    }
    
    func fetchWaitTimes() {
        guard let url = URL(string: timeURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(KAC_Time_Model_ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self.waitTimes = apiResponse.data
                    self.airportName = apiResponse.data.first?.iataCode ?? ""
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchWaitLevel() {
        guard let url = URL(string: levelURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(KAC_Level_Model_ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self.waitLevels = apiResponse.data
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    
    
    func fetchAll(tarr : [KAC_Time_Model], larr: [KAC_Level_Model])  {
        fetchWaitLevel()
        fetchWaitTimes()
        
  
    }
    
    
    
}



