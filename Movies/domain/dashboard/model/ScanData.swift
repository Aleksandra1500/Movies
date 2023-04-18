//
//  ScanData.swift
//  Movies
//
//  Created by RMS on 18/04/2023.
//

import Foundation


struct ScanData: Identifiable {
    var id = UUID()
    let content: String
    
    init(content: String) {
        self.content = content
    }
}
