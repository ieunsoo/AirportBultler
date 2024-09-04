//
//  KAC_Parking_View.swift
//  AirportButler
//
//  Created by lee eunsoo on 9/4/24.
//

import SwiftUI

struct KAC_Parking_View: View {
    @StateObject private var viewModel:KAC_Parking_ViewModel
    
    //navigation에서 보내는 데이터 받는 변수
    var sendCode:String = ""
    var airportName:String = ""
    
    init(sendCode: String, airportName: String) {
        
        switch sendCode {
        case "김포공항":
            self.sendCode = "GMP"
        case "김해공항":
            self.sendCode = "PUS"
        case "제주공항":
            self.sendCode = "CJU"
        case "청주공항":
            self.sendCode = "CJJ"
        case "대구공항":
            self.sendCode = "TAE"
        default:
            self.sendCode = "PUS"
        }
        
        self.airportName = airportName
        
        //생성자에서 인스턴스 초기화
        _viewModel = StateObject(wrappedValue: KAC_Parking_ViewModel(iataCode: sendCode))
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.parkingInfos) { info in
                        NavigationLink(destination: ParkingDetailView(parkingInfo: info)) {
                            VStack(alignment: .leading) {
//                                Text(info.aprEng)
//                                    .font(.headline)
//                                Text(info.aprKor)
//                                    .font(.subheadline)
                                HStack{
                                    Text("\(info.parkingAirportCodeName)")
                                        .font(.headline)
                                    Spacer()
                                    
                                    if(info.parkingFullSpace == info.parkingIstay){
                                        Text("만차")
                                            .padding(4)
                                            .background(Color.red)
                                            .cornerRadius(3.0)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.white)
                                    }else{
                                        Text("\(info.parkingFullSpace - info.parkingIstay)대 가능")
                                            .padding(4)
                                            .background(Color.green)
                                            .cornerRadius(3.0)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.white)
                                    }
                                }
                                Text("총 공간: \(info.parkingFullSpace)")
                                Text("주차중: \(info.parkingIstay)")
                                Text("불러온 시간: \(formattedDate(info.parkingGetdate, time: info.parkingGettime))")
                                    .font(.caption)
                                    .foregroundStyle(Color.gray)
                                    .padding(.top, 2)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("\(airportName) 주차 정보")
            .onAppear {
                viewModel.fetchParkingData()
            }
        }
    }

    private func formattedDate(_ date: String, time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        guard let date = dateFormatter.date(from: date),
              let time = timeFormatter.date(from: time) else {
            return "\(date) \(time)"
        }
        
        let fullFormatter = DateFormatter()
        fullFormatter.dateFormat = "MM월 dd일 HH:mm:ss"
        
        return fullFormatter.string(from: date)
    }
}


//TODO: Mapkit으로 주차장 위치 보여주기 (급한건 아님)
struct ParkingDetailView: View {
    var parkingInfo: KAC_Parking_Model
    
    var body: some View {
        VStack(alignment: .leading) {
//            Text("공항 영문 이름: \(parkingInfo.aprEng)")
//                .font(.title2)
//            Text("공항 국문 이름: \(parkingInfo.aprKor)")
//                .font(.title)
            Text("주차장 이름: \(parkingInfo.parkingAirportCodeName)")
            Text("총 공간: \(parkingInfo.parkingFullSpace)")
            Text("현재 주차 중인 차량: \(parkingInfo.parkingIstay)")
            Text("데이터 날짜: \(parkingInfo.parkingGetdate)")
            Text("데이터 시간: \(parkingInfo.parkingGettime)")
//            Spacer()
        }
        .navigationTitle("주차장 세부 정보")
    }
}

#Preview {
    KAC_Parking_View(sendCode: "PUS", airportName: "김해공항")
}

