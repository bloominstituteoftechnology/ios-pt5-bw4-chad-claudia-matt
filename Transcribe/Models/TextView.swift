//
//  TextView.swift
//  Transcribe
//
//  Created by Claudia Maciel on 8/21/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

// Makes multi-line text view but won't save changes
import  SwiftUI

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    
    var placeholderText: String = "Enter message"
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = UIFont.systemFont(ofSize: 17)
        
        textView.text = placeholderText
        textView.textColor = .placeholderText
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if text != "" || uiView.textColor == .label {
            uiView.text = text
            uiView.textColor = .label
        }
        
        uiView.delegate = context.coordinator
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines
        return self.frame(height: height)
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
            }
        }
    }
    
}
