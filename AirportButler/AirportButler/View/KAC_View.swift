//
//  AirprotWaitTimeDetailView.swift
//  AirportButler
//
//  Created by 류기현 on 8/6/24.
//

import SwiftUI

/*
TODO: 혼잡도 레벨 api 불러오기
TODO: 하단에 운영시간, 데이터에 대한 설명이 있었으면...
 */
struct KAC_View: View {
    @StateObject private var times:KAC_Time_ViewModel
    
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
        _times = StateObject(wrappedValue: KAC_Time_ViewModel(sendCode))
    }
    
    //일단은 레벨은 api안쓰고 시간을 계산해서 사용
    func checkLevel(_ lvl: Int) -> Color {
        let lvlint = lvl / 60
        
        switch lvlint {
        case ..<5:
            return .blue
        case 5..<10:
            return .green
        case 10..<20:
            return .orange
        case 20...:
            return .red
        default:
            return .gray
        }
    }
    
    var body: some View {
        
         NavigationStack {
             ZStack{
                 Color.bgGray
                     .ignoresSafeArea()
                 
                 List(times.waitTimes){time in
                     
                     @State var levelA: Color = checkLevel(time.avgTimeA)
                     @State var levelB: Color = checkLevel(time.avgTimeB)
                     @State var levelC: Color = checkLevel(time.avgTimeC)
                     @State var levelD: Color = checkLevel(time.avgTimeD)
                     
                     VStack(spacing: 15) {
                         VStack {
                             HStack {
                                 Text("국내선 탑승수속 정보")
                                     .foregroundStyle(Color.subtitleGray)
                                     .font(.system(size: 16, weight: .heavy))
                                     .padding(.horizontal, 25)
                                     .frame(width: 200, height: 21, alignment: .leading)
                                 Spacer()
                                 
                                 //새로고침 버튼
                                 Button(action: {
                                     var currentDate = Date()// 현재 날짜와 시간 가져오기
                                     var dateFormatter = DateFormatter()// DateFormatter를 사용하여 날짜 형식 지정
                                     dateFormatter.dateFormat = "HH:mm:ss" // 원하는 형식으로 지정
                                     // 현재 시간 문자열로 변환
                                     var currentTimeString = dateFormatter.string(from: currentDate)
                                     print("새로고침 되었습니다 (기준시간 \(currentTimeString))")
                                     times.fetchWaitTimes()
                                 }) {
                                     Image(systemName: "arrow.clockwise.circle.fill").foregroundStyle(Color.gray)
                                 }.padding(.horizontal, 25)
                             }
                             
                             Spacer()
                                 .frame(height: 20)
                             
                             VStack(spacing: 10) {
                                 Text("\(time.avgTimeAll / 60) 분")
                                     .frame(width: 100,height: 18)
                                     .font(.system(size: 32, weight: .heavy))
                                     .foregroundStyle(Color.accentBlue)
                                 
                                 Text("예상소요시간")
                                     .frame(width: 89, height: 18)
                                     .font(.system(size: 16, weight: .heavy))
                                     .bold()
                                     .foregroundStyle(Color.subtitleGray)
                             }
                             
                             HStack {
                                 
                                 
                                 HStack(spacing: 1) {
                                     
                                     Circle()
                                         .frame(width: 10, height: 10)
                                         .foregroundStyle(Color.blue)
                                     
                                     Text("원활")
                                         .frame(height: 10)
                                         .font(.system(size: 13))
                                         .bold()
                                 }
                                 
                                 HStack(spacing: 1) {
                                     
                                     Circle()
                                         .frame(width: 10, height: 10)
                                         .foregroundStyle(Color.green)
                                     
                                     Text("보통")
                                         .frame(height: 10)
                                         .font(.system(size: 13))
                                         .bold()
                                 }
                                 
                                 HStack(spacing: 1) {
                                     
                                     Circle()
                                         .frame(width: 10, height: 10)
                                         .foregroundStyle(Color.orange)
                                     
                                     Text("혼잡")
                                         .frame(height: 10)
                                         .font(.system(size: 13))
                                         .bold()
                                 }
                                 
                                 HStack(spacing: 1) {
                                     
                                     Circle()
                                         .frame(width: 10, height: 10)
                                         .foregroundStyle(Color.red)
                                     
                                     Text("매우혼잡")
                                         .frame(height: 10)
                                         .font(.system(size: 13))
                                         .bold()
                                 }
                                 
                                 
                             }
                             .frame(width: 245, height: 44)
                             .font(.system(size: 13))
                             

                             
                         }
                         .frame(width: 370, height: 144) //MARK: 총 소요시간
                         .background(Color.white)
                         .cornerRadius(15)
                        
                         
                         VStack {
                             HStack{
                                 //api를 불러온 시간 표시
                                 Text("기준시간 \(time.processHour)")
                                     .padding(.horizontal, 20)
                                     .foregroundStyle(Color.subtitleGray)
                                     .font(.system(size: 15))
                                 Spacer()
                                 
                                 //정상 운영중인지 데이터 표시
                                 if(time.operationStatus != "1"){
                                     Text("현재 운영시간이 아닙니다")
                                         .padding(.horizontal, 20)
                                         .foregroundStyle(Color.red)
                                         .font(.system(size: 15))
                                         .fontWeight(.bold)
                                 }
                             }
                             .padding(.vertical)
                             .padding(.top, 35)
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 120)
                                 
                                 Circle()
                                     .frame(width: 30, height: 30)
                                     .foregroundStyle(Color.circleGray)
                                 
                                 Spacer()
                                     .frame(width: 20)
                                 
                                 Text("공항도착")
                                     .bold()
                                     .frame(width: 100, alignment: .leading)
                                     .padding(.leading, 1)
                                 
                                 Spacer()
                                     .frame(width: 85)
                                 
                             }.frame(height: 14) //MARK: 공항 도착
                             
                             HStack {
                                 Spacer().frame(width: 40)
                                 Spacer()
                                     .frame(width: 100)
                                 
                                 Rectangle()
                                     .frame(width: 5)
                                     .foregroundStyle(Color.gray)
                                 
                                 Spacer()
                             }.frame(height: 51) //    ~
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 120)
                                 
                                 Circle()
                                     .frame(width: 30, height: 30)
                                     .foregroundStyle(Color.circleGray)
                                 
                                 
                                 Spacer()
                                     .frame(width: 20)
                                 
                                 
                                 Text("셀프 체크인")
                                     .bold()
                                     .frame(width: 100, alignment: .leading)
                                     .padding(.leading, 1)
                                 
                                 Spacer()
                                     .frame(width: 85)
                                 
                             }.frame(height: 14) //MARK: 셀프 체크인
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 40)
                                 
                                 Text("\(time.avgTimeA / 60) 분")
                                     .frame(width: 65, height: 28)
                                     .bold()
                                     .foregroundStyle(Color.white)
                                     .background(levelA)
                                     .cornerRadius(10)
                                 
                                 Spacer()
                                     .frame(width: 35)
                                 
                                 Rectangle()
                                     .frame(width: 5)
                                     .foregroundStyle(levelA)
                                 
                                 Spacer()
                                 
                                 
                             }.frame(height: 51) //MARK: ~Level A
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 120)
                                 
                                 Circle()
                                     .frame(width: 30, height: 30)
                                     .foregroundStyle(Color.circleGray)
                                 
                                 
                                 Spacer()
                                     .frame(width: 20)
                                 
                                 
                                 Text("신분 확인")
                                     .bold()
                                     .frame(width: 100, alignment: .leading)
                                     .padding(.leading, 1)
                                 
                                 Spacer()
                                     .frame(width: 85)
                                 
                             }.frame(height: 14) //MARK: 신분 확인
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 40)
                                 
                                 Text("\(time.avgTimeB / 60) 분")
                                     .frame(width: 65, height: 28)
                                     .bold()
                                     .foregroundStyle(Color.white)
                                     .background(levelB)
                                     .cornerRadius(10)
                                 
                                 Spacer()
                                     .frame(width: 35)
                                 
                                 Rectangle()
                                     .frame(width: 5)
                                     .foregroundStyle(levelB)
                                 
                                 
                                 Spacer()
                                 
                                 
                             }.frame(height: 51) //MARK: ~Level B
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 120)
                                 
                                 Circle()
                                     .frame(width: 30, height: 30)
                                     .foregroundStyle(Color.circleGray)
                                 
                                 
                                 Spacer()
                                     .frame(width: 20)
                                 
                                 
                                 Text("보안 검색")
                                     .bold()
                                     .frame(width: 100, alignment: .leading)
                                     .padding(.leading, 1)
                                 
                                 Spacer()
                                     .frame(width: 85)
                                 
                             }.frame(height: 14) //MARK: 보안 검색
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 40)
                                 
                                 //시간블록
                                 Text("\(time.avgTimeC / 60) 분")
                                     .frame(width: 65, height: 28)
                                     .bold()
                                     .foregroundStyle(Color.white)
                                     .background(levelC)
                                     .cornerRadius(10)
                                 
                                 Spacer()
                                     .frame(width: 35)
                                 
                                 //색막대
                                 Rectangle()
                                     .frame(width: 5)
                                     .foregroundStyle(levelC)
                                 
                                 Spacer()
                                 
                                 
                             }.frame(height: 51) //MARK: ~Level C
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 120)
                                 
                                 Circle()
                                     .frame(width: 30, height: 30)
                                     .foregroundStyle(Color.circleGray)
                                 
                                 
                                 Spacer()
                                     .frame(width: 20)
                                 
                                 
                                 Text("탑승시간")
                                     .bold()
                                     .frame(width: 100, alignment: .leading)
                                     .padding(.leading, 1)
                                 
                                 Spacer()
                                     .frame(width: 85)
                                 
                             }.frame(height: 14) //MARK: 탑승 시간
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 40)
                                 
                                 Text("\(time.avgTimeD / 60) 분")
                                     .frame(width: 65, height: 28)
                                     .bold()
                                     .foregroundStyle(Color.white)
                                     .background(levelD)
                                     .cornerRadius(10)
                                 
                                 Spacer()
                                     .frame(width: 35)
                                 
                                 Rectangle()
                                     .frame(width: 5)
                                     .foregroundStyle(levelD)
                                 
                                 Spacer()
                                 
                                 
                             }.frame(height: 51) //MARK: ~Level D(시간만 제공, 레벨은 미제공)
                             
                             HStack {
                                 
                                 Spacer()
                                     .frame(width: 120)
                                 
                                 Circle()
                                     .frame(width: 30, height: 30)
                                     .foregroundStyle(Color.circleGray)
                                 
                                 
                                 Spacer()
                                     .frame(width: 20)
                                 
                                 
                                 Text("출발")
                                     .bold()
                                     .frame(width: 100, alignment: .leading)
                                     .padding(.leading, 1)
                                 
                                 Spacer()
                                     .frame(width: 85)
                                 
                             }.frame(height: 14) //MARK: 출발
                             
                             Spacer().padding(30)
                             
                             
                         }.frame(width: 370, height: 506)
                             .background(Color.white)
                             .cornerRadius(15)
                         
                     }.background(Color.bgGray)
                 }
                 .onAppear {
                     times.fetchWaitTimes()
//                     self.airportName = times.airportName.first
                     
                 }
             }
             .navigationTitle(airportName)// MARK: 네비게이션 타이틀 헤더 수정 필요, 너무 작게나옴
         }
         
    }
}

#Preview {
    KAC_View(sendCode: "PUS", airportName: "김해공항")
}
