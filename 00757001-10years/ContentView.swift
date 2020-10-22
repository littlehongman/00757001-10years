//
//  ContentView.swift
//  test_animation
//
//  Created by HungJie on 2020/10/14.
//

import SwiftUI

struct ContentView: View {
    @State private var number = 0
    var body : some View{
        NavigationView{
            VStack{
                GeometryReader { geometry in
                    VStack{
                        Image("title")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: geometry.size.width / 3 * 2)
                        Text("選擇一位來看他二十年的變化")
                            .fontWeight(.bold)
                            .font(.system(size : 30))
                            .offset(y:20)
                        HStack(){
                            NavigationLink(destination:LebronView()){
                                SelectView(name: "LeBron\r\nJames", color: Color.yellow)
                            }
                            NavigationLink(destination:JordanView(number: self.number)){
                                SelectView(name: "Michael\r\n Jordan", color: Color.red)
                            }
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                                    self.number += 1
                            }
                        }
                        }.offset(y:70)
                    }
                }
            }
            .background(Image("logo").resizable().position(x: 300, y: 395).frame(width: 600, height: 900).opacity(0.8))
            .navigationTitle("Twenty Years Challenge")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SelectView : View {
    var name : String
    var color : Color
    var body: some View{
        VStack{
            Text(name)
                .fontWeight(.bold)
                .font(.system(size : 28))
                .foregroundColor(Color.black)
        }
        .frame(width: 200, height: 150)
        .background(color)
        .border(Color.black, width: 10)
        .cornerRadius(0)
        
    }
}


struct LebronView : View {
    @State private var brightnessAmount : Double = 0
    @State private var scale : CGFloat = 1
    @State private var playerTime = Date()
    let today = Date()
    let startDate = Calendar.current.date(byAdding: .year, value: -19,to: Date())!
    var year: Int {Calendar.current.component(.year, from: playerTime)}
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                VStack {
                    Image("lebron\(year)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width / 2 * 3)
                        .clipped()
                        .brightness(brightnessAmount)
                        .scaleEffect(scale)
                        .position(x:207,y:270)
                        
                    Form{
                        HStack {
                            Text("大小")
                            Slider(value: $scale, in: 0...1, minimumValueLabel: Image(systemName: "photo.fill").imageScale(.small), maximumValueLabel: Image(systemName: "photo.fill").imageScale(.large)){ Text("") }
                        }
                        HStack {
                            Text("亮度")
                            Slider(value: $brightnessAmount, in: 0...1, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small), maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)) { Text("")}
                        }
                        DatePicker("年份",selection: $playerTime,in: startDate...today ,displayedComponents: .date)
                        
                    }.position(x:207,y:360)
                    
                }
                
            }
        }
    }
}

struct JordanView : View{
    @State private var Autoplay : Bool = true
    @State private var picNum: Float = 0
    @State private var timer: Timer?
    
    var number : Int
    
    init(number: Int) {
           self.number = number
           print("NumberView init \(number)")
       }
    
    var body: some View{
        VStack {
            Group{
                PhotoView(picNum: Autoplay ? ((number/3) % 20) + 1983 : Int(picNum+1983), name: "jordan")
                Slider(value: $picNum, in: 0...19, step: 1)
                               .accentColor(.red)
                    .offset(y:180)
            }.position(x: 207, y:140)
            Toggle(isOn: $Autoplay) {
                Text("自動播放")
                    .font(.system(size: 25))
            }
        }
        //.offset(y:-40)
    }
}

struct PhotoView : View{
    var picNum : Int
    var name : String
    var body : some View{
        GeometryReader { geometry in
            VStack {
                Image(name + "\(self.picNum)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.width / 2 * 3)
                    .clipped()
                Text(String(self.picNum))
                    .fontWeight(.bold)
                    .font(.system(size: 30))
            }
        }
    }
}


