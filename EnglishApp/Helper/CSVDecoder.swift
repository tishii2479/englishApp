//
//  CSVDecoder.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class CSVDecoder {
    
    func convertCSVFileToStringArray(resourceName: String) -> Array<String>? {
        var csvLines = [String]()
        
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "csv") else {
            print("error: csv file not found")
            return nil
        }
        
        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            csvLines = csvString.components(separatedBy: .newlines)
            csvLines.removeLast()   // 最後の改行を削除するため
        } catch let error as NSError {
            print("error: data not found, message: \(error)")
            return nil
        }
        
        return csvLines
    }
    
}
