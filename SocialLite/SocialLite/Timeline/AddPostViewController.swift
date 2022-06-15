//
//  AddPostViewController.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

final class AddPostViewController: UIViewController {
    
    private let modalView = UIView()
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let postButton = UIButton()
    private let cancelButton = UIButton()
    private let charactersLeftlabel = UILabel()
    
    private var allowEditing = true
    private let maxCharacters = 140
    
    var post: ((_ title: String, _ description: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        setUpSubViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - UIScreen.main.bounds.height / 4 + 8)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setUpSubViews() {
        modalView.layer.cornerRadius = 6.0
        modalView.layer.borderColor = UIColor.lightGray.cgColor
        modalView.layer.borderWidth = 1.2
        modalView.backgroundColor = .white
        modalView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(modalView)
        
        titleTextField.placeholder = "addPost.title".localize()
        titleTextField.borderStyle = .roundedRect
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        modalView.addSubview(titleTextField)
        
        descriptionTextView.delegate = self
        descriptionTextView.text = "addPost.body".localize()
        descriptionTextView.textColor = .lightGray
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 4.0
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        modalView.addSubview(descriptionTextView)
        
        postButton.setTitle("addPost.post".localize(), for: .normal)
        postButton.setTitleColor(.white, for: .normal)
        postButton.backgroundColor = .systemBlue
        postButton.layer.cornerRadius = 4.0
        postButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        postButton.addTarget(self, action: #selector(postTapped), for: .touchUpInside)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        modalView.addSubview(postButton)
        
        cancelButton.setTitle("addPost.cancel".localize(), for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        modalView.addSubview(cancelButton)
        
        charactersLeftlabel.text = String(maxCharacters)
        charactersLeftlabel.textColor = .lightGray
        charactersLeftlabel.translatesAutoresizingMaskIntoConstraints = false
        modalView.addSubview(charactersLeftlabel)
        
        NSLayoutConstraint.activate([
            modalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            modalView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            modalView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24.0),
            self.view.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: 24.0),
            
            titleTextField.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 8.0),
            titleTextField.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 8.0),
            modalView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor, constant: 8.0),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8.0),
            descriptionTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            
            postButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 8.0),
            titleTextField.trailingAnchor.constraint(equalTo: postButton.trailingAnchor),
            modalView.bottomAnchor.constraint(equalTo: postButton.bottomAnchor, constant: 8.0),
            
            charactersLeftlabel.centerYAnchor.constraint(equalTo: postButton.centerYAnchor),
            postButton.leadingAnchor.constraint(equalTo: charactersLeftlabel.trailingAnchor, constant: 8.0),
            
            cancelButton.centerYAnchor.constraint(equalTo: postButton.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)
        ])
    }
    
    @objc func postTapped() {
        guard let title = titleTextField.text, let description = descriptionTextView.text else {
            return
        }
        
        post?(title, description)
        dismiss(animated: true)
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true)
    }
}

extension AddPostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        charactersLeftlabel.text = String(maxCharacters - textView.text.count)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let canEdit = textLimit(existingText: textView.text, newText: text, limit: maxCharacters)
        
        if !canEdit {
            charactersLeftlabel.shake(0.01)
        }
        
        return canEdit
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "addPost.body".localize()
            textView.textColor = UIColor.lightGray
        }
        
        NSLayoutConstraint.activate([
            modalView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    func textPasteConfigurationSupporting(_ textPasteConfigurationSupporting: UITextPasteConfigurationSupporting, performPasteOf attributedString: NSAttributedString, to textRange: UITextRange) -> UITextRange {
            if let textView = textPasteConfigurationSupporting as? UITextView {
                let pasteBoard = UIPasteboard.general
                if pasteBoard.hasStrings {
                    textView.insertText(pasteBoard.string ?? "Some thing went wrong, please enter your text")
                }
            }
            return textRange
    }
    
    private func textLimit(existingText: String,
                           newText: String,
                           limit: Int) -> Bool {
        let isAtLimit = existingText.count + newText.count <= limit
        return isAtLimit
    }
}
