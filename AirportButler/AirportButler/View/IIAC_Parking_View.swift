//
//  IIAC_Parking_View.swift
//  AirportButler
//
//  Created by lee eunsoo on 9/4/24.
//
import SwiftUI
import Foundation
import Combine

// 주차 정보 모델
struct IIAC_Parking_Model: Identifiable, Codable {
    let id = UUID()
    let floor: String       // 층
    let parking: String     // 현재 주차현황 (문자열로 받음)
    let parkingarea: String // 총 주차 가능자리 (문자열로 받음)
    let datetm: String      // 불러온 시간
}

// API 응답 모델
struct IIAC_Parking_Response: Codable {
    struct Body: Codable {
        let items: [IIAC_Parking_Model]
    }
    
    struct Header: Codable {
        let resultCode: String
        let resultMsg: String
    }
    
    let header: Header
    let body: Body
}

struct APIResponse: Codable {
    let response: IIAC_Parking_Response
}

class IIAC_Parking_ViewModel: ObservableObject {
    @Published var parks: [IIAC_Parking_Model] = []
    @Published var error: String? = nil
    
    func fetchParkingData() async {
        let urlString = "http://apis.data.go.kr/B551177/StatusOfParking/getTrackingParking?serviceKey=nnByrN0KJ1dbbHuo3E9UCOBBBQqwHKGmbcEjwd%2FuylRy0nuLOJwlP0LXkclyELieIpiV%2BbngWn%2FxkXoQnmYcvQ%3D%3D&numOfRows=10&pageNo=1&type=json"
        
        guard let url = URL(string: urlString) else {
            print("URL ERROR: URL 처리 중 오류가 발생했습니다.")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Received Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            
            if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data) {
                if decodedResponse.response.header.resultCode == "00" {
                    parks = decodedResponse.response.body.items
                } else {
                    error = decodedResponse.response.header.resultMsg
                }
            } else {
                print("Decoding failed")
            }
        } catch {
            print("Invalid data: \(error.localizedDescription)")
        }
    }
}

struct IIAC_Parking_View: View {
    @StateObject var park_datas = IIAC_Parking_ViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if let error = park_datas.error {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else if park_datas.parks.isEmpty {
                    Text("No data available")
                        .foregroundColor(.gray)
                } else {
                    List(park_datas.parks) { item in
                        VStack(alignment: .leading) {
                            
                            if( Int(item.parkingarea)! - Int(item.parking)! > 10){
                                Text(item.floor)
                                    .font(.headline)
                            }else{
                                HStack{
                                    
                                    Text(item.floor)
                                            .font(.headline)
                                            .foregroundStyle(Color.red)
                                        Text("만차")
                                        .padding(3)
                                        .background(Color.red)
                                }
                            }
                            
                            
                            VStack (alignment: .leading){
                                Text("현재 주차 현황: \(item.parking)")
                                Text("총 주차 가능자리: \(item.parkingarea)")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 0.3)
                            
                        }.padding(.vertical, 7)
                    }
                            
                }
            }
            .navigationTitle("주차장 정보")
            .task {
                await park_datas.fetchParkingData()
            }
            
        }
    }
}

#Preview {
    IIAC_Parking_View()
}
