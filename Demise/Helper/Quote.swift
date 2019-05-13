//
//  Global.swift
//  Mortality
//
//  Created by Allen Lai on 1/24/18.
//  Copyright © 2018 Allen Lai. All rights reserved.
//

import Foundation


class Quote {
    
    static var allQuotes: [Quote] = []
    
    var content: String
    var author: String
    
    init (content: String, author: String) {
        self.content = content
        self.author = author
    }
    
    static func readAllQuotesTxt() {
        if let path = Bundle.main.path(forResource: "demise", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings: [String] = data.components(separatedBy: .newlines)
                for ss in myStrings {
                    let array = ss.components(separatedBy: "+")
                    let auther = String(array[0])
                    let content = String(array[1])
                    Quote.allQuotes.append(Quote(content: String(content), author: auther))
                }
            } catch {
                print(error)
            }
        }
    }
    
}
