//
//  TestViews.swift
//  Essayist
//
//  Created by Kyle Nazario on 11/25/20.
//

import SwiftUI
import HighlightedTextEditor

struct MarkdownEditorA: View {
    @State var text: String
    
    init() {
        let fileURL = URL(string: "file:///Users/kylenazario/apps/HighlightedTextEditor/Tests/Essayist/iOS-EssayistUITests/MarkdownSample.md")!
        let markdown = try! String(contentsOf: fileURL, encoding: .utf8)
        let end = markdown.index(of: "## Blockquotes")!
        let firstPart = String(markdown.prefix(upTo: end))
        _text = State<String>(initialValue: firstPart)
    }
    
    var body: some View {
        HighlightedTextEditor(text: $text, highlightRules: .markdown)
    }
}

struct MarkdownEditorB: View {
    @State var text: String
    
    init() {
        let fileURL = URL(string: "file:///Users/kylenazario/apps/HighlightedTextEditor/Tests/Essayist/iOS-EssayistUITests/MarkdownSample.md")!
        let markdown = try! String(contentsOf: fileURL, encoding: .utf8)
        let endOfFirstPart = markdown.index(of: "## Blockquotes")!
        let endOfSecondPart = markdown.index(of: "\n\n## Tables")!
        let secondPart = String(markdown[endOfFirstPart..<endOfSecondPart])
        _text = State<String>(initialValue: secondPart)
    }
    
    var body: some View {
        HighlightedTextEditor(text: $text, highlightRules: .markdown)
    }
}

struct MarkdownEditorC: View {
    @State var text: String
    
    init() {
        let fileURL = URL(string: "file:///Users/kylenazario/apps/HighlightedTextEditor/Tests/Essayist/iOS-EssayistUITests/MarkdownSample.md")!
        let markdown = try! String(contentsOf: fileURL, encoding: .utf8)
        let endOfSecondPart = markdown.index(of: "\n\n## Tables")!
        let thirdPart = String(markdown[endOfSecondPart..<markdown.endIndex])
        _text = State<String>(initialValue: thirdPart)
    }
    
    var body: some View {
        HighlightedTextEditor(text: $text, highlightRules: .markdown)
    }
}

struct URLEditor: View {
    @State var text: String = "No formatting\n\nhttps://www.google.com/"
    
    var body: some View {
        HighlightedTextEditor(text: $text, highlightRules: .url)
    }
}

let betweenUnderscores = try! NSRegularExpression(pattern: "_[^_]+_", options: [])
#if os(macOS)
let fontTraits: NSFontDescriptor.SymbolicTraits = [.bold, .italic, .tightLeading]
typealias NSUIColor = NSColor
typealias NSUIFont = NSFont
#else
let fontTraits: UIFontDescriptor.SymbolicTraints = [.traitBold, .traitItalic, .traitTightLeading]
typealias NSUIColor = UIColor
typealias NSUIFont = UIFont
#endif

struct FontTraitEditor: View {
    @State private var text: String = "The text is _formatted_"
    
    var body: some View {
        HighlightedTextEditor(text: $text, highlightRules: [
            HighlightRule(pattern: betweenUnderscores, formattingRules: [
                TextFormattingRule(fontTraits: fontTraits)
            ])
        ])
    }
}

struct NSAttributedStringKeyEditor: View {
    @State private var text: String = "The text is _formatted_"
    
    var body: some View {
        HighlightedTextEditor(text: $text, highlightRules: [
            HighlightRule(pattern: betweenUnderscores, formattingRules: [
                TextFormattingRule(key: .font, value: NSUIFont.systemFont(ofSize: 20)),
                TextFormattingRule(key: .backgroundColor, value: NSUIColor.blue),
                TextFormattingRule(key: .foregroundColor, value: NSUIColor.red),
                TextFormattingRule(key: .underlineStyle, value: NSUnderlineStyle.single.rawValue),
                TextFormattingRule(key: .underlineColor, value: NSUIColor.purple)
            ])
        ])
    }
}
