import Foundation

class DummyMaker {
    let encoder = JSONEncoder()
    let path = "/Users/inseopark/JsonServer/db.json"
    let languages = ["C++", "Swift", "Java", "Python", "Kotlin"]
    let names = ["Jung-Hwan", "Yun-Su", "Yu-ri", "Robert", "Tom", "Paul", "Oliver", "Emily", "Emma", "Jessica", "So-Yeon", "Julia", "John"]
    
    init() {
        self.encoder.outputFormatting = .prettyPrinted
    }
    
    func make() {
        var users = Users()

        for i in self.names.indices.shuffled() {
            users.users.append(
                User(id: i,
                     name: self.names[i],
                     phone: "010-\(Int.random(in: 1000...9999))-\(Int.random(in: 1000...9999))",
                     usingLanguage: self.languages.randomElement()!
                    )
                )
        }

        if let encodedData = try? encoder.encode(users) {
            let pathAsURL = URL(fileURLWithPath: self.path)
            do {
                try encodedData.write(to: pathAsURL)
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    }
}
