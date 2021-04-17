//
//  ViewModel.swift
//  nasay
//
//  Created by thisdjango on 17.04.2021.
//

import Foundation

class ViewModel {
    
    func grabData(onResult: @escaping (Models) -> Void) {
        
        let apiToken = "3EjFZutuTPDcwnVdBT2vwiDc2kFDLCtLsLI4gfZg"
        let baseURL = "https://api.nasa.gov/planetary/apod?count=50&api_key=\(apiToken)"
        
        guard let url = URL(string: baseURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil { return }
            
            guard let data = data else { return }
            
            if let model = try? JSONDecoder().decode(Models.self, from: data) {
                onResult(model)
            }
        }
        
        task.resume()
    }
    
    func loadImage(string: String, onResponse: @escaping ((Data) -> Void)) {
        guard let url = URL(string: string) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else { return }
            
            guard let data = data else { return }
            
            onResponse(data)
        }
        
        task.resume()
    }
}
