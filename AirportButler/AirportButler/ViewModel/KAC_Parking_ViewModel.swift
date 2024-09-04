//
//  KAC_Parking_ViewModel.swift
//  AirportButler
//
//  Created by lee eunsoo on 9/4/24.
//

import Foundation
import Combine

// MARK: - ViewModel
class KAC_Parking_ViewModel: NSObject, ObservableObject, XMLParserDelegate {
    @Published var parkingInfos: [KAC_Parking_Model] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var urlString:String = ""
    
    var iataCode: String = "nil"
    
    private var currentElement = ""
    private var currentAprEng = ""
    private var currentAprKor = ""
    private var currentParkingAirportCodeName = ""
    private var currentParkingFullSpace = ""
    private var currentParkingIstay = ""
    private var currentParkingGetdate = ""
    private var currentParkingGettime = ""
    
    init(iataCode: String) {
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
        
        //api url 완성
        urlString="http://openapi.airport.co.kr/service/rest/AirportParking/airportparkingRT?serviceKey=nnByrN0KJ1dbbHuo3E9UCOBBBQqwHKGmbcEjwd%2FuylRy0nuLOJwlP0LXkclyELieIpiV%2BbngWn%2FxkXoQnmYcvQ%3D%3D&schAirportCode=\(self.iataCode)"
    }
    
    func fetchParkingData() {
        guard let url = URL(string: urlString) else {
             DispatchQueue.main.async {
                 self.errorMessage = "Invalid URL."
             }
             return
         }
         
        
        print("Fetching data from URL: \(url)")
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        DispatchQueue.global(qos: .background).async {
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                parser.parse()
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load data."
                    self.isLoading = false
                }
            }
        }
    }
    
    // MARK: - XMLParserDelegate methods, 클래스 내부에 위치한다.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item" {
            resetCurrentValues()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        print("Found characters for element \(currentElement): \(trimmedString)")
        
        switch currentElement {
        case "aprEng":
            currentAprEng += trimmedString
        case "aprKor":
            currentAprKor += trimmedString
        case "parkingAirportCodeName":
            currentParkingAirportCodeName += trimmedString
        case "parkingFullSpace":
            currentParkingFullSpace += trimmedString
        case "parkingIstay":
            currentParkingIstay += trimmedString
        case "parkingGetdate":
            currentParkingGetdate += trimmedString
        case "parkingGettime":
            currentParkingGettime += trimmedString
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let fullSpace = Int(currentParkingFullSpace),
               let istay = Int(currentParkingIstay) {
                let newItem = KAC_Parking_Model(
                    aprEng: currentAprEng,
                    aprKor: currentAprKor,
                    parkingAirportCodeName: currentParkingAirportCodeName,
                    parkingFullSpace: fullSpace,
                    parkingIstay: istay,
                    parkingGetdate: currentParkingGetdate,
                    parkingGettime: currentParkingGettime
                )
                
                DispatchQueue.main.async {
                    self.parkingInfos.append(newItem)
                }
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        DispatchQueue.main.async {
            self.errorMessage = "XML Parsing Error: \(parseError.localizedDescription)"
            self.isLoading = false
        }
    }
    
    private func resetCurrentValues() {
        currentAprEng = ""
        currentAprKor = ""
        currentParkingAirportCodeName = ""
        currentParkingFullSpace = ""
        currentParkingIstay = ""
        currentParkingGetdate = ""
        currentParkingGettime = ""
    }
}

