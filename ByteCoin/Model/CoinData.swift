//
//  CoinData.swift
//  ByteCoin
//
//  Created by Tomiwa Idowu on 20/07/2022.
//

import Foundation


struct CoinData: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
