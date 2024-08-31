//
//  MainView.swift
//  AirportButler
//
//  Created by lee eunsoo on 8/17/24.
//

import SwiftUI

let airports: [String] = [ "인천공항", "김포공항", "김해공항", "제주공항" ]
enum airportNames: String, CaseIterable, Identifiable {
    case 인천공항 = "인천공항"
    case 김포공항
    case 김해공항
    case 제주공항
    case 청주공항
    case 대구공항
    
    var id: Self{self}
    
}

struct MainView: View {
    @State var name:String
    
    var body: some View {
        HStack{
            HStack{
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                Spacer()
            }
            .padding(.top, 10)
            
            HStack{
                Spacer()
                Picker("change airport", selection: $name) {
                    ForEach(airportNames.allCases) { aname in
                        Text(aname.rawValue.capitalized)
                    }
                }.foregroundStyle(Color.black) // 스타일 변경 가능
            }
            
        }
        .padding(.bottom, 10)
        
        
        NavigationStack{
            
            ScrollView{
                
                HStack{
                    Spacer()
                    Text("공항 혼잡도")
                    Spacer()
                }
                .frame(height: 130)
                .background(Color.green)
                .cornerRadius(10.0)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                HStack{
                    Spacer()
                    Text("주차장 정보")
                    Spacer()
                    
                }
                .frame(height: 130)
                .background(Color.gray)
                .cornerRadius(10.0)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
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
        
        
    }
    
}

#Preview {
    MainView(name: "인천국제공항")
}
