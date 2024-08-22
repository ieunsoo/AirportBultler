import SwiftUI
import Combine
import Foundation

struct IIAC_DailyPassenger_1: View {
    @StateObject private var viewModel = ApiViewModel2()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: 0xF2F2F2)
                    .ignoresSafeArea()
                ScrollView {
                    VStack() {
                        ForEach(filteredKeys, id: \.self) { key in
                            Section(header: Text("")) {
                                ForEach(viewModel.groupedItems[key] ?? []) { item in
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(convertToTime(key))
                                            .fontWeight(.bold)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .padding(.bottom, 5)
                                        Divider()
                                            .background(Color.gray)
                                        HStack {
                                            Text("출국장")
                                            Text("1, 2")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text("\(convertToInt(item.t1sum5))")
                                                .fontWeight(.bold)
                                            + Text("명")
                                        }
                                        HStack {
                                            Text("출국장")
                                            Text("3")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text("\(convertToInt(item.t1sum6))")
                                                .fontWeight(.bold)
                                            + Text("명")
                                        }
                                        HStack {
                                            Text("출국장")
                                            Text("4")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text("\(convertToInt(item.t1sum7))")
                                                .fontWeight(.bold)
                                            + Text("명")
                                        }
                                        HStack {
                                            Text("출국장")
                                            Text("5, 6")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text("\(convertToInt(item.t1sum8))")
                                                .fontWeight(.bold)
                                            + Text("명")
                                        }
                                        Divider()
                                            .background(Color.gray)
                                        HStack {
                                            Text("합계")
                                            Spacer()
                                            Text("\(convertToInt(item.t1sumset2))")
                                                .fontWeight(.bold)
                                            + Text("명")
                                        }
                                    }
                                    .padding(.vertical, 15)
                                    .padding(.horizontal, 20)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    
                                    .padding(.bottom, 1)
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchItems()
                }
            }
        }
    }
    
    var filteredKeys: [String] {
        return viewModel.groupedItems.keys
            .filter { key in
                guard let hour = Int(key.prefix(2)) else { return false }
                return hour >= 0 && hour < 6
            }
            .sorted()
    }
    
    func convertToTime(_ key: String) -> String {
        let hour = key.prefix(2)
        return "\(hour):00"
    }
    
    func convertToInt(_ value: String) -> String {
        if let doubleValue = Double(value) {
            return String(Int(doubleValue))
        } else {
            return value
        }
    }
}

struct IIAC_DailyPassenger_1_Previews: PreviewProvider {
    static var previews: some View {
        IIAC_DailyPassenger_1()
    }
}
