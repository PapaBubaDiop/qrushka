//
//  ContentView.swift
//  qRushka
//
//  Created by User on 22.11.2021.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var model: ModelView
    var body: some View {
        if model.isValid() {
            QRView(model: model)
        } else {
            if model.isProduction() {
                InputView(model: model)
            } else {
                SimpleView(model: model)
            }
        }
    }
}


struct InputView: View {
    var model: ModelView
    @State private var name: String = ""
    @State private var birth: String = ""
    @State private var passport: String = ""
    
    var body: some View {
        VStack {
            //          Image(systemName: "calendar").resizable()
            //              .frame(width: 150, height: 150)
            Spacer()
            TextField("3 буквы ФИО", text: $name)
            TextField("ДР 15.03.1964", text: $birth)
            TextField("2+3 цифры паспорта", text: $passport)
            Spacer()
            HStack {
                Button("Сделай QR", action: {
                    self.model.tapQRButton(name, birth, passport)
                })
                Spacer()
                Button("Очистить", action: {
                    name=""
                    birth = ""
                    passport = ""
                    self.model.tapClean()
                })
            }.padding()
            Spacer()
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}



struct SimpleView: View {
    var model: ModelView
    @State private var string: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Набери любой текст и").foregroundColor(.gray)
            Text("программа сформирует").foregroundColor(.gray)
            Text("соответствующий").foregroundColor(.gray)
            Text("QR код")
            Image(systemName: "qrcode").resizable()
                .frame(width: 44, height: 44).padding()
            
            
            TextField("Не более 80 символов", text: $string)
            Spacer(minLength: 160)
            HStack {
                Button("Сделай QR", action: {
                    self.model.tapQRButton(string)
                })
                Spacer()
                Button("Очистить", action: {
                    string=""
                    self.model.tapClean()
                })
            }.padding()
            Spacer()
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}





struct QRView: View {
    var model: ModelView
    @State private var isSharePresented: Bool = false
    var body: some View {
        VStack {
            if let image = model.generateQRCode() {
                Text("QR код").bold()
                Text("успешно сформирован")
                Spacer()
                Image(uiImage: image).resizable()
                    .frame(width: 200, height: 200)
            } else {
                Text("QR код").bold().foregroundColor(.red)
                Text("не сформирован").foregroundColor(.red)
                Spacer()
                Image(systemName: "qrcode").resizable()
                    .frame(width: 75, height: 75)
            }
            Spacer()
            Button("Назад", action: {           self.model.tapClean()
            } ).padding()
            if let image = model.generateQRCode() {
                
                
                Button("Переслать") {
                    self.isSharePresented = true
                }
                .sheet(isPresented: $isSharePresented, onDismiss: {
                    print("Dismiss")
                }, content: {
                    ActivityViewController(activityItems: [image])
                }).padding()
                
            }
            
        }.padding()
        Spacer()
    }
}
    
    
struct ActivityViewController: UIViewControllerRepresentable {
        var activityItems: [Any]
        var applicationActivities: [UIActivity]? = nil
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
            let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
            return controller
        }
        
        func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
        
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(model: ModelView())
        }
    }
