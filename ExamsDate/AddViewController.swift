//
//  AddViewController.swift
//  ExamsDate
//
//  Created by Buse Topuz on 19.06.2022.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var denemeLabel: UILabel!
    @IBOutlet weak var denemePicker: UIPickerView!
    //picker view seçeneklerinden oluşan dizi
    let alerts = ["At time of event","5 minutes before", "10 minutes before", "30 minutes before","1 hour before", "2 hours before"]
    
    public var completion: ((String, String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton)) //save button tanımlanması
        denemePicker.delegate = self
       denemePicker.dataSource = self
        denemeLabel.text = alerts[0] //başlangıçta pickerview 0. index gösterilir
    }
    //picker view section sayısı
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
    //picker view seçenek sayısı
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return alerts.count
        }
    //picker view satırlarında gösterilecek değer
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return alerts[row]
    }
    //picker viewdan seçilen değerin okunması ve labela yazılması
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        denemeLabel.text = alerts[row]
    }

    //ekle butonuna basıldığında bildirime gönderilecek datei belirler. Seçilen seçeneğe göre dakika, saat azaltır.
    @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
            let bodyText = bodyField.text, !bodyText.isEmpty {
            if denemeLabel.text == alerts[0]{
                let targetDate = datePicker.date
                completion?(titleText, bodyText, targetDate)
            } else if denemeLabel.text == alerts[1]{
                let targetDate = datePicker.date.addingTimeInterval(-5 * 60)
                completion?(titleText, bodyText, targetDate)
            } else if denemeLabel.text == alerts[2]{
                let targetDate = datePicker.date.addingTimeInterval(-10 * 60)
                completion?(titleText, bodyText, targetDate)
            } else if denemeLabel.text == alerts[3]{
                let targetDate = datePicker.date.addingTimeInterval(-30 * 60)
                completion?(titleText, bodyText, targetDate)
            }else if denemeLabel.text == alerts[4]{
                let targetDate = datePicker.date.addingTimeInterval(-1 * 60 * 60)
                completion?(titleText, bodyText, targetDate)
            }else if denemeLabel.text == alerts[5]{
                let targetDate = datePicker.date.addingTimeInterval(-2 * 60 * 60)
                completion?(titleText, bodyText, targetDate)
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}

