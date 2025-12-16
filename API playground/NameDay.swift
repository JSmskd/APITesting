//
//  NameDay.swift
//  API playground
//
//  Created by John Sencion on 12/16/25.
//

import SwiftUI

struct NameDay: View {
    let object:nd = .init()
    @State var næme:String = ""
    var body: some View {
        Button {
            print("opening")
            let i = næme
            let inp = "{\n\t\"name\": \"\(i)\"\n}"
            
            var cur = inp.data(using: .utf8)
            
            var b = object.makeRequest(resource: "getname", method: "POST", body: (content: cur, type: "application/json"))
            print("\(b.httpMethod ?? "ERROT") \(b.url?.description ?? "ERROT")")
            for i in b.allHTTPHeaderFields ?? [:] {
                        print("\t\(i.key): \(i.value)")
                    }
                    print("")
            print(String(data: b.httpBody ?? .init(), encoding: .utf8) ?? "ERROT")
            
//            var a = //rq.ses.dataTask(with: b)
            global.session.dataTask(with: b) { data, urlr, e in
                if let data = data, let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any]  ?? ["message":"nope","success":-1,"data":Data()]{
                    if let data = (data["data"] as? [[String:Any]]) {
                        for data in data {
                            if let data = data["country"] {
                                print("\(data) ", terminator: "")
                                print("{")
                            }
                            for i in 0..<data.count-1 {
                                let data = data[i.description] as? [String: Any] ?? ["day":-1,"month":-1,"name":"Ferenc"]
                                print("\t\(data["month"] as? Int ?? -1)/\(data["day"] as? Int ?? -1) : \((data["name"] as? String ?? "").split(separator: ", "))")
                            }
                            print("}",terminator: ", ")
                        }
                    }
                }
            }.resume()
        } label: {
            Text("hi")
        }

        TextField("Enter name", text: $næme)
    }
}

#Preview {
    NameDay()
}
struct nd:api {
    var token: String = ""
    
    var url : String = "https://nameday.abalin.net:443"
    var apiModifier:String = "api/V2"
    init(){}
}
