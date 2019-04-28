//
//  ChatGateway.swift
//  chum
//
//  Created by James Saeed on 26/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import Foundation
import Firebase
import MessageKit

let NEW_DB_REF = Firestore.firestore()

class ChatGateway {
	
	static let shared = ChatGateway()
	
	func createNewChat(forMembers members: [User]) {
		NEW_DB_REF.collection("threads").addDocument(data: [members[0].uid: true, members[1].uid: true])
	}
	
	func identifyConversationId(forMembers members: [User], completion: @escaping (_ conversationId: String) -> ()) {
		NEW_DB_REF.collection("threads").getDocuments { (snapshot, error) in
			for document in snapshot!.documents {
				let conversationId = document.documentID
				guard let firstPerson = document.data()[members[0].uid] as? Bool else { return }
				guard let secondPerson = document.data()[members[1].uid] as? Bool else { return }
				
				if firstPerson && secondPerson {
					completion(conversationId)
				}
			}
		}
	}
	
	func getMessages(forConversation conversationId: String, completion: @escaping (_ messages: [ChumMessage]) -> ()) {
		NEW_DB_REF.collection("threads").document(conversationId).collection("messages").addSnapshotListener { (snapshot, error) in
			var messages = [ChumMessage]()
			
			for document in snapshot!.documents {
				let messageId = document.documentID
				guard let senderId = document.data()["senderId"] as? String else { return }
				guard let senderName = document.data()["senderName"] as? String else { return }
				guard let content = document.data()["content"] as? String else { return }
				
				let message = ChumMessage(sender: Sender(id: senderId, displayName: senderName), messageId: messageId, content: content)
				messages.append(message)
			}
			
			completion(messages)
		}
	}
	
	func saveMessage(_ message: ChumMessage, forConversation conversationId: String, completion: () -> ()) {
		NEW_DB_REF.collection("threads").document(conversationId).collection("messages").document(message.messageId).setData([
				"content": message.content,
				"senderId": message.sender.id,
				"senderName": message.sender.displayName
			])
		
		completion()
	}
}

struct ChumMessage: MessageType {
	
	var sender: Sender
	var messageId: String
	var sentDate: Date
	var kind: MessageKind
	var content: String
	
	init(sender: Sender, messageId: String, content: String) {
		self.sender = sender
		self.messageId = messageId
		self.content = content
		self.kind = .text(content)
		self.sentDate = Date()
	}
}
