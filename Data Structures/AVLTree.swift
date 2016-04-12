//
//  AVLTree.swift
//  Swift Data Structures
//
//  Created by AARON FARBER on 4/11/16.
//  Copyright © 2016 Aaron Farber. All rights reserved.
//

import Foundation

extension TreeNode {
    
    var balance : Int {
        let leftHeight = left?.height ?? -1
        let rightHeight = right?.height ?? -1
        
        special = max(leftHeight, rightHeight) + 1
        
        return rightHeight - leftHeight
    }
    
    var height : Int { return special }
}

class AVLTree<Element : Comparable> : BinarySearchTree<Element> {
    
    // MARK: - Initializers
    
    override init(arrayLiteral : [Element]) {
        
        super.init(arrayLiteral: arrayLiteral)
    }
    
    // MARK: - Element Balance
    
    override internal func balanceNode(node : TreeNode<Element>) -> TreeNode<Element> {
        
        // left left
        
        if node.balance < -1 && node.left?.balance <= 0 {
            return rightRotate(node)
        }
            
            // left right
            
        else if node.balance < -1 && node.left?.balance > 0 {
            node.left = leftRotate(node.left!)
            return rightRotate(node)
        }
            
            // right right
            
        else if node.balance > 1 && node.right?.balance >= 0 {
            return leftRotate(node)
        }
            
            // right left
            
        else if node.balance > 1 && node.right?.balance < 0 {
            node.right = rightRotate(node.right!)
            return leftRotate(node)
        }
        
        return node
    }
}