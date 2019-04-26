//
//  ConversationViewController.swift
//  chum
//
//  Created by James Saeed on 26/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar

class ConversationViewController: MessagesViewController, Storyboarded {

	weak var coordinator: ChatsCoordinator?
	
	var conversationId: String?
	var sender: User?
	var recipient: User?
	var messages = [ChumMessage]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		messagesCollectionView.messagesDataSource = self
		messagesCollectionView.messagesLayoutDelegate = self
		messagesCollectionView.messagesDisplayDelegate = self
		messageInputBar.delegate = self
		
		setNavigationTitle()
		loadConversation()
		configureLayout()
    }
}

// MARK: - Conversation Data

extension ConversationViewController: MessagesDataSource {
	
	func currentSender() -> Sender {
		return sender!.toSender()
	}
	
	func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
		return messages[indexPath.section]
	}
	
	func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
		return messages.count
	}
}

// MARK: - Conversation Appearence

extension ConversationViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {
	
	func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
		return isFromCurrentSender(message: message) ? UIColor(named: "primary")! : UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
	}
	
	func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
		avatarView.kf.setImage(with: recipient?.imageURL)
	}
	
	func configureLayout() {
		let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
		layout?.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
		
		layout?.setMessageOutgoingAvatarSize(.zero)
		layout?.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)))
		layout?.setMessageOutgoingMessageBottomLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)))
		
		messageInputBar.sendButton.titleLabel?.textColor = UIColor(named: "primary")!
	}
	
	/*
	func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
		return 18
	}
	
	func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
		return 20
	}
	
	func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
		return 16
	}
*/
}

// MARK: - Functionality

extension ConversationViewController: MessageInputBarDelegate {
	
	private func setNavigationTitle() {
		self.navigationItem.title = "\(recipient!.firstName) \(recipient!.lastName)"
	}
	
	private func loadConversation() {
		ChatGateway.shared.identifyConversationId(forMembers: [sender!, recipient!]) { (conversationId) in
			self.conversationId = conversationId
			ChatGateway.shared.getMessages(forConversation: conversationId) { (pulledMessages) in
				self.messages.removeAll()
				self.messages = pulledMessages
				self.messagesCollectionView.reloadData()
			}
		}
	}
	
	private func generateMessageId() -> String {
		let uuid = UUID().uuidString
		let prefix = String(format: "%05d", messages.count)
		let id = prefix + "-" + uuid
		
		return id
	}
	
	func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
		let newMessage = ChumMessage(sender: currentSender(), messageId: generateMessageId(), content: text)
		
		ChatGateway.shared.saveMessage(newMessage, forConversation: conversationId!) {
			messageInputBar.inputTextView.text = ""
		}
	}
}
