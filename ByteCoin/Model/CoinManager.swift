//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "F488DB23-FC52-4FBA-B3BB-0FC6542D3CE9"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getCoinPrice(for currency: String) -> Void {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    
  
    
    
    func performRequest(with urlString: String) -> Void {
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let exchangeRate = self.parseJson(safeData) {
//                    print(String(data: safeData, encoding: String.Encoding.utf8) as String? as Any)
                        print(exchangeRate.rate)
                        print(exchangeRate.time)
                        print(exchangeRate.assetIdQuote)
                    }
                }
                }
            task.resume()
            }
        }
    
    
    
    func parseJson(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(CoinData.self, from: coinData)
            let time = decodedData.time
            let assetIdBase = decodedData.asset_id_base
            let assetIdQuote = decodedData.asset_id_quote
            let rate = decodedData.rate
            let coin = CoinModel(time: time, assetIdBase: assetIdBase, assetIdQuote: assetIdQuote, rate:rate)
            return coin
        }
        catch {
//            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
//    let time: String
//     let asset_id_base: String
//     let asset_id_quote : String
//     let rate: Double
    
    
//    var backToString = String(data: somedata!, encoding: String.Encoding.utf8) as String!
}
