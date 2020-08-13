//
//  WorkbookViewModel.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

class WorkbookViewModel: ObservableObject {
    
    @Published var workbook: Workbook!
    
    init(workbook: Workbook) {
        self.workbook = workbook
    }
    
    func updateView() {
        self.objectWillChange.send()
    }
}
