import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}


//TODO: 내일 예상치도 보여주기
struct IIAC_DailyPassenger_View: View {
    @StateObject private var viewModel = ApiViewModel2()
    @State private var selectedTerminalButton: Int? = 1
    @State private var selectedTimeButton: Int? = 1

    enum selectedTerminal: Int{
        case one
        case two
    }
    enum selectedTime: Int{
        case Q1 = 1
        case Q2 = 2
        case Q3 = 3
        case Q4 = 4
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Color.bgGray).ignoresSafeArea()
                
                VStack {
                    HStack(spacing: 20) {
                        T1Button
                        T2Button
                    }
                    Divider()
                        .background(Color.gray)
                        .padding(.bottom, 20)
                    HStack(spacing: 80) {
                        Text(currentDate)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20))
                        HStack {
                            if selectedTerminalButton == 1 {
                                Text("총 인원수")
                                Text("\(viewModel.totalT1SumSet)")
                                    .fontWeight(.bold)
                                + Text("명")
                            }
                            else if selectedTerminalButton == 2 {
                                Text("총 인원수")
                                Text("\(viewModel.totalT2SumSet)")
                                    .fontWeight(.bold)
                                + Text("명")
                            }
                        }
                    }
                    HStack {
                        timeButton(text: "00:00 ~06:00", buttonIndex: 1)
                        timeButton(text: "06:00 ~12:00", buttonIndex: 2)
                        timeButton(text: "12:00 ~18:00", buttonIndex: 3)
                        timeButton(text: "18:00 ~24:00", buttonIndex: 4)
                    }
                    if selectedTerminalButton == 1 {
                        
                        if selectedTimeButton == 1 {
                            IIAC_DailyPassenger_1()
                                .padding(.horizontal, 20)
                        } else if selectedTimeButton == 2 {
                            IIAC_DailyPassenger_2()
                                .padding(.horizontal, 20)
                        } else if selectedTimeButton == 3 {
                            IIAC_DailyPassenger_3()
                                .padding(.horizontal, 20)
                        } else if selectedTimeButton == 4 {
                            IIAC_DailyPassenger_4()
                                .padding(.horizontal, 20)
                        }
                        
                    } else if selectedTerminalButton == 2 {
                        
                        if selectedTimeButton == 1 {
                            IIAC_DailyPassenger_5()
                                .padding(.horizontal, 20)
                        } else if selectedTimeButton == 2 {
                            IIAC_DailyPassenger_6()
                                .padding(.horizontal, 20)
                        } else if selectedTimeButton == 3 {
                            IIAC_DailyPassenger_7()
                                .padding(.horizontal, 20)
                        } else if selectedTimeButton == 4 {
                            IIAC_DailyPassenger_8()
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
//            .navigationTitle("인 천 공 항")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    backButton
//                }
//            }
        }
        .navigationTitle("인천공항")
        .onAppear {
            viewModel.fetchItems()
        }
        
    }
    
    var backButton: some View {
        Button(action: {
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
    
    var T1Button: some View {
        Button(action: {
            selectedTerminalButton = 1
        }) {
            Text("제1여객터미널")
                .foregroundColor(selectedTerminalButton == 1 ? .black : .gray)
                .font(.headline)
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .cornerRadius(15)
                .lineLimit(1)
                .shadow(color: selectedTerminalButton == 1 ? Color(hex: 0xD9D9D9) : .clear, radius: 4, x: 4, y: 4)
        }
    }
    
    var T2Button: some View {
        Button(action: {
            selectedTerminalButton = 2
        }) {
            Text("제2여객터미널")
                .foregroundColor(selectedTerminalButton == 2 ? .black : .gray)
                .font(.headline)
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .cornerRadius(15)
                .lineLimit(1)
                .shadow(color: selectedTerminalButton == 2 ? Color(hex: 0xD9D9D9) : .clear, radius: 4, x: 4, y: 4)
        }
    }
    
    var currentDate: String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: currentDate)
    }
    
    func timeButton(text: String, buttonIndex: Int) -> some View {
        Button(action: {
            selectedTimeButton = buttonIndex
        }) {
            Text(text)
                .padding()
                .foregroundColor(selectedTimeButton == buttonIndex ? .black : .gray)
                .lineLimit(2)
                .frame(width: 90)
                .underline(selectedTimeButton == buttonIndex)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IIAC_DailyPassenger_View()
    }
}
