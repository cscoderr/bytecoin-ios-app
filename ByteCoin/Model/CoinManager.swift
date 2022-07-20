//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Tomiwa Idowu on 20/07/2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateWithData(_ coinManager: CoinManager, coinData: CoinData)
    func didErrorOccur(error: Error)
}

struct CoinManager {
    let currencyArray: [String] = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let baseUrl: String = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey: String = "CE284963-0091-4762-841F-70D6C5DA9A46"
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let url = "\(baseUrl)/\(currency)?apikey=\(apiKey)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
        
            let session = URLSession(configuration: .default)
        
                let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didErrorOccur(error: error!)
                    return
                }
                
                if let safeData = data {
                    let decodedData = decodeJSON(safeData)
                    delegate?.didUpdateWithData(self, coinData: decodedData!)
                }
            }
            task.resume()
        }
    }
    
    func decodeJSON(_ data: Data) -> CoinData? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(CoinData.self, from: data)
            return response
        } catch {
            delegate?.didErrorOccur(error: error)
            return nil
        }
    }
}
