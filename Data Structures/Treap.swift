//
//  Treap.swift
//  Swift Data Structures
//
//  Created by AARON FARBER on 4/11/16.
//  Copyright © 2016 Aaron Farber. All rights reserved.
//

import Foundation

extension TreeNode {
    
    var priority : Int {
        
        if special == 0 {
            special = Int(arc4random_uniform(UID_MAX - 1)) + 1
        }
        return special
    }
}

class Treap<Element : Comparable> : BinarySearchTree<Element> {
    
    // MARK: - Initializers
    
    override init(arrayLiteral : [Element]) {
        
        super.init(arrayLiteral: arrayLiteral)
    }
    
    // MARK: - Element Balance
    
    override internal func balanceNode(node : TreeNode<Element>) -> TreeNode<Element> {
        
        if let left = node.left where left.priority > node.priority {
            return rightRotate(node)
        }
        
        if let right = node.right where right.priority > node.priority {
            return leftRotate(node)
        }
        
        return node
    }
    
}