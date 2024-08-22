//
//  MainView.swift
//  AirportButler
//
//  Created by lee eunsoo on 8/17/24.
//

import SwiftUI

let airports: [String] = [ "인천공항", "김포공항", "김해공항", "제주공항" ]

struct MainView: View {
    @State var name:String
    
    var body: some View {
        VStack{
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
                Picker("Select a color", selection: $name) {
                    ForEach(airports, id: \.self) {
                        Text($0)
                    }
                } // 스타일 변경 가능
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray)
        
        TabView{
            
            ScrollView{
                
                
                
                HStack{
                    Spacer()
                    Text("공항 혼잡도")
                    Spacer()
                }
                .frame(height: 130)
                .background(Color.red)
                .cornerRadius(10.0)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                
                HStack{
                    Spacer()
                    Text("주차장 정보")
                    Spacer()
                    
                }
                .frame(height: 130)
                .background(Color.green)
                .cornerRadius(10.0)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                HStack{
                    Spacer()
                    Text("항공편 정보")
                    Spacer()
                    
                    
                }
                .frame(height: 300)
                .background(Color.blue)
                .cornerRadius(10.0)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                HStack{
                    Spacer()
                    Text("편의시설 정보")
                    Spacer()
                    
                }
                .frame(height: 130)
                .background(Color.orange)
                .cornerRadius(10.0)
                .padding(.horizontal)
                .padding(.bottom, 5)
            }
            .tabItem { Text("홈화면") }
            
            Text("hello world")
                .tabItem {
                    
                    Text("공항 전광판")
                }
            
            Text("hello world")
                .tabItem { Text("즐겨찾기") }
            
            Text("hello world")
                .tabItem { Text("전체") }
            
            
        }
    }
}

#Preview {
    MainView(name: "즐겨찾기 공항")
}
