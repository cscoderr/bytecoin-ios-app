//
//  ViewController.swift
//  ByteCoin
//
//  Created by Tomiwa Idowu on 20/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pricePicker: UIPickerView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pricePicker.delegate = self
        pricePicker.dataSource = self
        coinManager.delegate = self
    }

}

//MARK: - UIPickerViewDelegate & UIPickerViewDataSource

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdateWithData(_ coinManager: CoinManager, coinData: CoinData) {
        DispatchQueue.main.async {
            self.symbolLabel.text = coinData.asset_id_quote
            self.priceLabel.text = String(format: "%.2f", coinData.rate)
        }
    }
    
    func didErrorOccur(error: Error) {
        print(error)
    }
}
