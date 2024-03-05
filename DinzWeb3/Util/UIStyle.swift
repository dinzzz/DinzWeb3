//
//  UIStyle.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 01.03.2024..
//

import Foundation
import UIKit

public struct UIStyle {
    
    public struct Color {
        
        public struct Basic {
            
            static var primary: UIColor {
                return .white
            }
            
            static var secondary: UIColor {
                return .black
            }
        }
        
        public struct Background {
            
            static var primary: UIColor {
                return .black
            }
            
            static var cards: UIColor {
                return .white.withAlphaComponent(0.2)
            }
            
            static var rows: UIColor {
                return .black.withAlphaComponent(0.8)
            }
            
            static var nftList: UIColor {
                return .white.withAlphaComponent(0.05)
            }
        }
    }
    
    public struct Font {
        
        public struct Headline {
            
            static var big: UIFont {
                return UIFont.systemFont(ofSize: 26, weight: .bold)
            }
        }
        
        public struct Body {
            
            static var regular: UIFont {
                return UIFont.systemFont(ofSize: 20, weight: .bold)
            }
            
            static var small: UIFont {
                return UIFont.systemFont(ofSize: 12, weight: .regular)
            }
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xf) * 17, (int & 0xf) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xff, int & 0xff)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xff, int >> 8 & 0xff, int & 0xff)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
