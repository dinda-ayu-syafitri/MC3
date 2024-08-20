//
//  PinTextField.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import SwiftUI

struct PinTextField: UIViewRepresentable {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: PinTextField
        var textField: UITextField?

        init(parent: PinTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

        @objc func doneButtonTapped() {
            parent.isFocused.wrappedValue = false
            textField?.resignFirstResponder() 
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        context.coordinator.textField = textField
        textField.keyboardType = .numberPad
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: context.coordinator, action: #selector(Coordinator.doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolbar

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isFocused.wrappedValue {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
}
