//
//  Parking.swift
//  AirportButler
//
//created by chole & Rong
//

import SwiftUI

struct Parking: View {
    var body: some View {
        VStack {
            Text("PARKING LOT STATUS")
                .font(.subheadline)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.blue)
                
            
            Text("주차현황")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom,50)
            
            HStack {
                // 여객주차장 텍스트를 왼쪽에 위치
                Text("여객주차장(P1+P2)")
                    .padding(.leading, 10) // 왼쪽 여백 추가
                Spacer() // 텍스트를 왼쪽에 붙이기 위해 Spacer 추가
            }
           
            
            // 첫 번째 LazyHStack을 ScrollView로 감싸서 수평 스크롤 가능하게 설정
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) { // 간격 조정 가능
                    ForEach(0..<3, id: \.self) { index in
                        VStack {
                            Capsule()
                                .fill(index == 0 ? Color.green : index == 1 ? Color.yellow : Color.red)
                                .frame(width: 100, height: 20)
                            
                            // 텍스트 색상은 검정색으로 통일
                            Text(index == 0 ? "여유" : index == 1 ? "보통" : "혼잡")
                                .padding(.top, 8)
                                .foregroundColor(.black) // 검정색으로 설정
                        }
                        .padding(.all, 4)
                    }
                }
                .frame(height: 60) // LazyHStack의 높이 조정
            }
            .frame(maxWidth: .infinity) // ScrollView가 화면 전체 너비를 차지하게 설정
            
            HStack {
                Text("P3 여객 (화물)")
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 20)
            
            // 두 번째 LazyHStack을 ScrollView로 감싸서 수평 스크롤 가능하게 설정
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) { // 간격 조정 가능
                    ForEach(0..<3, id: \.self) { index in
                        VStack {
                            Capsule()
                                .fill(index == 0 ? Color.green : index == 1 ? Color.yellow : Color.red) // 색상 변경
                                .frame(width: 100, height: 20)
                            
                            // 텍스트 색상은 검정색으로 통일
                            Text(index == 0 ? "여유" : index == 1 ? "보통" : "혼잡")
                                .padding(.top, 8)
                                .foregroundColor(.black) // 검정색으로 설정
                        }
                        .padding(.all, 4)
                    }
                }
                .frame(height: 60) // LazyHStack의 높이 조정
            }
            .frame(maxWidth: .infinity) 
            // ScrollView가 화면 전체 너비를 차지하게 설정
        }
        .padding()
    }
}

#Preview {
    Parking()
}

