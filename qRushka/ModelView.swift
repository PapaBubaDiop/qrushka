//
//  ModelView.swift
//  qRushka
//
//  Created by User on 22.11.2021.
//

import UIKit
import Social

class ModelView: ObservableObject {
    @Published private var model:UserModel = UserModel()
    @Published var json:[Web] = []

    func isValid()->Bool {
        return model.user.isValid
    }

    func isProduction()->Bool {
        json.isEmpty || 2 == json[0].id ? false : true
    }

    
    func tapQRButton(_ string:String) {
        model.updateUser(string: string)
    }

    func tapQRButton(_ name:String,_ birth:String,_ pass:String) {
        model.updateUser(name: name, birth: birth, pass: pass)
    }
 
    func tapClean() {
        model.cleanUser()
    }
    
    func generateQRCode() -> UIImage? {
        var uiImage: UIImage?
        let string = model.user.genUrl()

        if let data = string.data(using: String.Encoding.utf8) {
            if let filter = CIFilter(name: "CIQRCodeGenerator",
                                     parameters: ["inputMessage": data,
                                                  "inputCorrectionLevel": "L"]) {
                if let outputImage = filter.outputImage,
                   let cgImage = CIContext().createCGImage(outputImage,
                                                           from: outputImage.extent) {
                    let size = CGSize(width: outputImage.extent.width * 5.0,
                                      height: outputImage.extent.height * 5.0)
                    UIGraphicsBeginImageContext(size)
                    if let context = UIGraphicsGetCurrentContext() {
                        context.interpolationQuality = .none
                        context.draw(cgImage,
                                     in: CGRect(origin: .zero,
                                                size: size))
                        uiImage = UIGraphicsGetImageFromCurrentImageContext()
                    }
                    UIGraphicsEndImageContext()
                }
            }
        }
        return uiImage
    }
    
    
    
    func getRequest() {
        guard let url = URL(string: "http://www.bashni.org/sites/iphone/corona/qr_request.php") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedJson = try JSONDecoder().decode([Web].self, from: data)
                        self.json = decodedJson
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    
    
    
    
    
    
    
}


