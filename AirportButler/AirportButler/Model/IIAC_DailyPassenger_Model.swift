// MARK: - Models

import Combine
import Foundation

struct ApiResponse2: Codable {
    let response: ResponseData2
}

struct ResponseData2: Codable {
    let header: Header2
    let body: Body2
}

struct Header2: Codable {
    let resultCode: String
    let resultMsg: String
}

struct Body2: Codable {
    let items: [ApiItem]
}

struct ApiItem: Codable, Identifiable {
    let id = UUID()
    
    let adate: String
    let atime: String
    let t1sum1: String
    let t1sum2: String
    let t1sum3: String
    let t1sum4: String
    let t1sumset1: String
    let t1sum5: String
    let t1sum6: String
    let t1sum7: String
    let t1sum8: String
    let t1sumset2: String
    let t2sum1: String
    let t2sum2: String
    let t2sumset1: String
    let t2sum3: String
    let t2sum4: String
    let t2sumset2: String
}

