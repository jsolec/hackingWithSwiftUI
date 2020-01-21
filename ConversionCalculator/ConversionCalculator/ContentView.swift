//
//  ContentView.swift
//  ConversionCalculator
//
//  Created by Jesús Solé on 09/11/2019.
//  Copyright © 2019 jsolec. All rights reserved.
//

import SwiftUI

enum Temperature: Int {
    case celsius
    case fahrenheit
    case kelvin
}

struct ContentView: View {
    @State var temperature = ""
    @State var inputTemperatureType = 0
    @State var outputTemperatureType = 0
    
    private var temperatureOptions = ["Celsius", "Fahrenheit", "Kelvin"]
    private var resultTemperature: Double {
        return getTempConversion()
    }
    
    var body: some View {
        Form {
            Section(header: Text("Temperature to convert")) {
                TextField("Enter temperature", text: $temperature).keyboardType(.decimalPad)
                Picker("Input Temperature", selection: $inputTemperatureType) {
                    ForEach(0 ..< temperatureOptions.count) {
                        Text(self.temperatureOptions[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Result Temperature")) {
                Picker("Input Temperature", selection: $outputTemperatureType) {
                    ForEach(0 ..< temperatureOptions.count) {
                        Text(self.temperatureOptions[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Text("\(resultTemperature, specifier: "%.2f")")
            }
            
        }.navigationBarTitle("Conversion")
    }
    
    private func getTempConversion() -> Double {
        let temperatureValue = Double(temperature) ?? 0
        let inputType = Temperature(rawValue: inputTemperatureType) ?? .celsius
        let outputType = Temperature(rawValue: outputTemperatureType) ?? .celsius
        
        switch inputType {
        case .celsius:
            return getConvertCelsius(value: temperatureValue, outputType: outputType)
        case .fahrenheit:
            return getConvertFahrenheit(value: temperatureValue, outputType: outputType)
        case .kelvin:
            return getConvertKelvin(value: temperatureValue, outputType: outputType)
        }
    }
    
    private func getConvertCelsius(value: Double, outputType: Temperature) -> Double {
        switch outputType {
        case .celsius:
            return value
        case .fahrenheit:
            return (value * 9 / 5) + 32
        case .kelvin:
            return value + 273.15
        }
    }
    
    private func getConvertFahrenheit(value: Double, outputType: Temperature) -> Double {
        switch outputType {
        case .celsius:
            return (value - 32) * 5 / 9
        case .fahrenheit:
            return value
        case .kelvin:
            return (value - 32) * 5 / 9 + 273.15
        }
    }
    
    private func getConvertKelvin(value: Double, outputType: Temperature) -> Double {
        switch outputType {
        case .celsius:
            return value - 273.15
        case .fahrenheit:
            return (value - 273.15) * 9 / 5 + 32
        case .kelvin:
            return value
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
