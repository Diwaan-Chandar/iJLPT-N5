//
//  SVGPathParser.swift
//  JLPT-N5
//

import SwiftUI

public struct SVGPathParser {
    public static func parse(_ pathString: String) -> Path {
        var path = Path()
        
        // 1. Tokenize
        var tokens: [String] = []
        var currentToken = ""
        
        for char in pathString {
            if char.isLetter {
                if !currentToken.isEmpty {
                    tokens.append(currentToken)
                    currentToken = ""
                }
                tokens.append(String(char))
            } else if char == "," || char.isWhitespace {
                if !currentToken.isEmpty {
                    tokens.append(currentToken)
                    currentToken = ""
                }
            } else if char == "-" && !currentToken.isEmpty && currentToken.last != "e" && currentToken.last != "E" {
                tokens.append(currentToken)
                currentToken = String(char)
            } else {
                currentToken.append(char)
            }
        }
        if !currentToken.isEmpty {
            tokens.append(currentToken)
        }
        
        // 2. Parse Commands
        var index = 0
        var currentPoint = CGPoint.zero
        var lastControlPoint: CGPoint? = nil
        var currentCommand: String = " "
        
        func nextFloat() -> CGFloat? {
            guard index < tokens.count else { return nil }
            let str = tokens[index]
            if let f = Double(str) {
                index += 1
                return CGFloat(f)
            }
            return nil
        }
        
        while index < tokens.count {
            let token = tokens[index]
            if let firstChar = token.first, firstChar.isLetter {
                currentCommand = String(firstChar)
                index += 1
            } else if currentCommand == " " {
                // Not starting with a command and no active command, skip
                index += 1
                continue
            }
            
            switch currentCommand {
            case "M":
                if let x = nextFloat(), let y = nextFloat() {
                    currentPoint = CGPoint(x: x, y: y)
                    path.move(to: currentPoint)
                    lastControlPoint = nil
                    // Implicit L for subsequent coordinate pairs after M
                    currentCommand = "L"
                } else {
                    index += 1
                }
            case "C":
                if let x1 = nextFloat(), let y1 = nextFloat(),
                   let x2 = nextFloat(), let y2 = nextFloat(),
                   let x = nextFloat(), let y = nextFloat() {
                    let control1 = CGPoint(x: x1, y: y1)
                    let control2 = CGPoint(x: x2, y: y2)
                    let endPoint = CGPoint(x: x, y: y)
                    path.addCurve(to: endPoint, control1: control1, control2: control2)
                    currentPoint = endPoint
                    lastControlPoint = control2
                } else {
                    index += 1
                }
            case "c":
                if let dx1 = nextFloat(), let dy1 = nextFloat(),
                   let dx2 = nextFloat(), let dy2 = nextFloat(),
                   let dx = nextFloat(), let dy = nextFloat() {
                    let control1 = CGPoint(x: currentPoint.x + dx1, y: currentPoint.y + dy1)
                    let control2 = CGPoint(x: currentPoint.x + dx2, y: currentPoint.y + dy2)
                    let endPoint = CGPoint(x: currentPoint.x + dx, y: currentPoint.y + dy)
                    path.addCurve(to: endPoint, control1: control1, control2: control2)
                    currentPoint = endPoint
                    lastControlPoint = control2
                } else {
                    index += 1
                }
            case "S":
                if let x2 = nextFloat(), let y2 = nextFloat(),
                   let x = nextFloat(), let y = nextFloat() {
                    let control2 = CGPoint(x: x2, y: y2)
                    let endPoint = CGPoint(x: x, y: y)
                    
                    let control1: CGPoint
                    if let lastCP = lastControlPoint {
                        control1 = CGPoint(x: currentPoint.x + (currentPoint.x - lastCP.x),
                                           y: currentPoint.y + (currentPoint.y - lastCP.y))
                    } else {
                        control1 = currentPoint
                    }
                    
                    path.addCurve(to: endPoint, control1: control1, control2: control2)
                    currentPoint = endPoint
                    lastControlPoint = control2
                } else {
                    index += 1
                }
            case "s":
                if let dx2 = nextFloat(), let dy2 = nextFloat(),
                   let dx = nextFloat(), let dy = nextFloat() {
                    let control2 = CGPoint(x: currentPoint.x + dx2, y: currentPoint.y + dy2)
                    let endPoint = CGPoint(x: currentPoint.x + dx, y: currentPoint.y + dy)
                    
                    let control1: CGPoint
                    if let lastCP = lastControlPoint {
                        control1 = CGPoint(x: currentPoint.x + (currentPoint.x - lastCP.x),
                                           y: currentPoint.y + (currentPoint.y - lastCP.y))
                    } else {
                        control1 = currentPoint
                    }
                    
                    path.addCurve(to: endPoint, control1: control1, control2: control2)
                    currentPoint = endPoint
                    lastControlPoint = control2
                } else {
                    index += 1
                }
            case "L":
                if let x = nextFloat(), let y = nextFloat() {
                    currentPoint = CGPoint(x: x, y: y)
                    path.addLine(to: currentPoint)
                    lastControlPoint = nil
                } else {
                    index += 1
                }
            case "l":
                if let dx = nextFloat(), let dy = nextFloat() {
                    currentPoint = CGPoint(x: currentPoint.x + dx, y: currentPoint.y + dy)
                    path.addLine(to: currentPoint)
                    lastControlPoint = nil
                } else {
                    index += 1
                }
            default:
                // Unrecognized command or failure to parse
                index += 1
            }
        }
        
        return path
    }
}
