//
//  String+Extensions.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func stringHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func stringWidth(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    /**
     * Method that trim white spaces at begining and end of string
     */
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    static func randomUUID() -> String {
        return UUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
}
    
    
    // MARK: range
    
extension String {

    var fullRange:Range<String.Index> { return startIndex..<endIndex }
    
}
    
    // MARK: regex
    
extension String {
    
    mutating func stringByReplacingRegexMatches(pattern: String, with replaceString: String = "") {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            self = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceString)
        } catch {
            return
        }
    }
    
    func matches(for regex: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func rangeMatches(for regex: String) -> [Range<String.Index>] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                Range($0.range, in: self)!
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
} 

    // MARK: search
    
extension String {

    func countInstances(of stringToFind: String) -> Int {
        var stringToSearch = self
        var count = 0
        while let foundRange = stringToSearch.range(of: stringToFind, options: .diacriticInsensitive) {
            stringToSearch = stringToSearch.replacingCharacters(in: foundRange, with: "")
            count += 1
        }
        return count
    }

} 
    
    // MARK: Unicode

extension String {

    func unicodeToUtf8() -> String {
        if let data = data(using: String.Encoding.nonLossyASCII) {
            
            
            var encodedString = String(data: data, encoding: String.Encoding.utf8)
            
            if let accentChars = encodedString?.matches(for: "\\\\\\d\\d\\d") {
                
                for accentChar in accentChars {
                    // keep accent chars as is
                    if let accentCharData = accentChar.data(using: String.Encoding.utf8), let accentCharDecoded = String(data: accentCharData, encoding: String.Encoding.nonLossyASCII) {
                        encodedString  = encodedString?.replacingOccurrences(of: accentChar, with: accentCharDecoded)
                    }
                }
            }
            
            if let encodedStr = encodedString {
                return encodedStr
            }
            
        }
        return self
    }
    
    func utf8ToUnicode() -> String {
        if let data = data(using: String.Encoding.utf8) {
            if let decodedString = String(data: data, encoding: String.Encoding.nonLossyASCII) {
                return decodedString
            }
        }
        return self
    }
}


// MARK: Valid links
extension String {
    /**
     Check if a URL is valid with a fixed regular expresion.
     - returns: true if it's valid, false otherwise.
     */
    func isValidURL() -> Bool {
        let regExString = "(^(https?)://.*)"
        let regEx = try! NSRegularExpression(pattern: regExString, options: [.caseInsensitive])
        // Range of the first match has the same length as String length
        return regEx.matches(in: self, options: [], range: NSMakeRange(0, self.count)).count > 0
    }

    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

// MARK: From NSString
extension String {
    
    var lastPathComponent: String {
        get { return (self as NSString).lastPathComponent }
    }
    
    var pathExtension: String {
        get { return (self as NSString).pathExtension }
    }
    
    var stringByDeletingLastPathComponent: String {
        get { return (self as NSString).deletingLastPathComponent }
    }
    
    var stringByDeletingPathExtension: String {
        get { return (self as NSString).deletingPathExtension }
    }
    
    var pathComponents: [String] {
        get { return (self as NSString).pathComponents }
    }
    
    func stringByAppendingPathComponent(_ path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(_ ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)  
    }
    
    func indexOfCharacter(_ char: Character) -> Int? {
        if let idx = self.index(of: char) {
            return self.distance(from: self.startIndex, to: idx)
        }
        return nil
    }
    
    func boolValueFromString() -> Bool {
        return NSString(string: self).boolValue
    }
}
