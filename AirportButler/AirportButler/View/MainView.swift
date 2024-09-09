//
//  MainView.swift
//  AirportButler
//
//  Created by lee eunsoo on 8/17/24.
//
import SwiftUI

let airports: [String] = [ "인천공항", "김포공항", "김해공항", "제주공항", "청주공항", "대구공항" ]
enum airportNames: String, CaseIterable, Identifiable {
    case 인천공항
    case 김포공항
    case 김해공항
    case 제주공항
    case 청주공항
    case 대구공항
    
    var id: Self{self}
    
}




struct MainView: View {
    @State var name:String
    
    func AirportTrafficView() -> some View {
        if name == "인천공항" {
            return AnyView(IIAC_DailyPassenger_View())
        } else {
            return AnyView(KAC_View(sendCode: name, airportName: name))
        }
    }
    func trafficParkingView() -> some View {
        if name == "인천공항" {
            return AnyView(IIAC_Parking_View())
        } else {
            return AnyView(KAC_Parking_View(sendCode: name, airportName: name))
        }
    }
    var body: some View {
        
        
        
        
        NavigationStack{
            
            //MARK: title_bar
            HStack{
                HStack{
//                    Image("butler_emoji")
//                        .resizable()
//                        .frame(width: 50, height: 50)
                    Text("✈️ " + name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                    Spacer()
                }
                .padding(.top, 10)
                
                HStack{
                    Spacer()
                    Picker("change airport", selection: $name) {
                        ForEach(airports, id: \.self) {
                            Text($0)
                        }
                    }.foregroundStyle(Color.black) // 스타일 변경 가능
                }
                
            }
            .padding(.bottom, 10)
            
            /*
             HStack {
                 Spacer()
                 Text(" 여기에 날씨 데이터가 온다면?")
 //                Image("gimpo")
 //                    .resizable()
 //                    .aspectRatio(3/2, contentMode: .fit)
 //                    .clipShape(Circle())
 //                    .padding(.horizontal, 20)
                 Spacer()
             }
             .frame(height: 230)
             .background(Color.accentBlue)
             .cornerRadius(10.0)
             .padding(.horizontal)
             .padding(.bottom, 5)
             .hidden()
             */
            
            ScrollView{
                NavigationLink(destination: AirportTrafficView()) {
                        HStack {
                            Spacer()
                            Text("공항 혼잡도")
                                .foregroundStyle(Color.black)
                            Spacer()
                        }
                        .frame(height: 130)
                        .background(Color.green)
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                }
                NavigationLink(destination: trafficParkingView()) {
                    HStack{
                        Spacer()
                        Text("주차장 정보")
                            .foregroundStyle(Color.black)
                        Spacer()
                        
                    }
                    .frame(height: 130)
                    .background(Color.orange)
                    .cornerRadius(10.0)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                }
                
                
                
                HStack{
                    Spacer()
                    Text("항공편 정보")
                    Spacer()
                    
                    
                }
                .frame(height: 300)
                .background(Color.gray)
                .cornerRadius(10.0)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                HStack{
                    Spacer()
                    Text("편의시설 정보")
                    Spacer()
                    
                }
                .frame(height: 130)
                .background(Color.gray)
                .cornerRadius(10.0)
                .padding(.horizontal)
                .padding(.bottom, 5)
            }
            
        }
        .navigationTitle("김해공항")
        
        
    }
    
}

#Preview {
    MainView(name: "김해공항")
}
