import Foundation
import Combine
import Foundation

class ApiViewModel2: ObservableObject {
    @Published var groupedItems: [String: [ApiItem]] = [:]
    @Published var header: Header2?
    @Published var totalT1SumSet: Int = 0
    @Published var totalT2SumSet: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchItems() {
        guard let url = URL(string: "http://apis.data.go.kr/B551177/PassengerNoticeKR/getfPassengerNoticeIKR?serviceKey=3cGmOgwQRweRWUUKwWfH8QnbNRfZ08pSg8%2FQpVna7mIEgBCR%2BVzJdC1GaJbfei7I9lyvAAcLbApmjnLiUzgT2g%3D%3D&selectdate=0&type=json")
        else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ApiResponse2.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.header = response.response.header
                self?.groupItemsByAtime(items: response.response.body.items)
                print("Data fetched successfully: \(response.response.body.items)")
                self?.calculateTotalT1SumSet()
                self?.calculateTotalT2SumSet()
            })
            .store(in: &cancellables)
    }
    
    private func groupItemsByAtime(items: [ApiItem]) {
        self.groupedItems = Dictionary(grouping: items, by: { $0.atime })
        print("Grouped Items: \(self.groupedItems)")
    }
    
    func calculateTotalT1SumSet() {
        
        let items = groupedItems.values.flatMap { $0 }
        for item in items {
            print("Item t1sumset2: \(item.t1sumset2)")
        }
        let totalSum = items.reduce(0) { total, item in
            let value = Double(item.t1sumset2) ?? 0.0
            return total + value
        }
        self.totalT1SumSet = Int(totalSum)
        print("Total T1 Sum Set2: \(self.totalT1SumSet)")
    }
    
    func calculateTotalT2SumSet() {
        let items = groupedItems.values.flatMap { $0 }
        for item in items {
            print("Item t2sumset2: \(item.t2sumset2)")
        }
        let totalSum = items.reduce(0) { total, item in
            let value = Double(item.t2sumset2) ?? 0.0
            return total + value
        }
        self.totalT2SumSet = Int(totalSum)
        print("Total T2 Sum Set2: \(self.totalT2SumSet)")
    }
    
}
