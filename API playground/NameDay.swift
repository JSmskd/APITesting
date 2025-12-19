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
    typealias ds = (date:(month:Int,day:Int),name:[String])
    @State var eevil : [(country:String,dates:[ds])] = []
    @State var country:Int = -1
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
                country = -1
                if let data = data, let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any]  ?? ["message":"nope","success":-1,"data":Data()]{
                    
                    var international:[(country:String,dates:[ds])] = []
                    if let data = (data["data"] as? [[String:Any]]) {
                        for data in data {
                            if let data = data["country"] {
//                                print("\(data) ", terminator: "")
//                                print("{")
                                
                            }
                            
                            var dun:[ds] = []
                            for i in 0..<data.count-1 {
                                let data = data[i.description] as? [String: Any] ?? ["day":-1,"month":-1,"name":"Ferenc"]
                                dun.append((date: (month: data["month"] as? Int ?? -1, day: data["day"] as? Int ?? -1), name: (data["name"] as? String ?? "").split(separator: ", ").map { String($0) }))
                                
                                
                                
//                                print("\t\()/\() : \()")
//                                print("\t\(data["month"] as? Int ?? -1)/\(data["day"] as? Int ?? -1) : \((data["name"] as? String ?? "").split(separator: ", "))")
                            }
//                            print("}",terminator: ", ")
                            international.append((country: data["country"] as? String ?? UUID.init().uuidString, dates: dun))
                        }
                    }
                    print(international)
                    eevil = international
                }
            }.resume()
        } label: {
            Text("hi")
        }

        TextField("Enter name", text: $næme)
        Picker("Country", selection: $country) {
            Text("none").tag(-1, includeOptional: true)
            ForEach(0..<eevil.count, id: \.self) { i in
                Text(eevil[i].country).tag(i)
            }
        }
        if country != -1  && country < eevil.count{
            VStack{
            ForEach(eevil[country].dates, id: \.name.description) { i in
                LazyVGrid(columns: .init(repeating: .init(), count: 5)) {
//                    <#code#>
                //}//HStack {
                    Text("\(i.date.day)/\(i.date.month)").font(.title)
//                    Text("–")//I think this an emdash but I can't tell
//                    HStack(spacing: 8) {
                        ForEach(i.name, id:\.self) { o in
                            Text(o)
                        }
                    }
                }
            }
        }
    }
    struct nd:api {
        var token: String = ""
        
        var url : String = "https://nameday.abalin.net:443"
        var apiModifier:String = "api/V2"
        init(){}
    }
}

#Preview {
    NameDay()
}

