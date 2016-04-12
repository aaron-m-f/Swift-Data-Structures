//
//  TreeRotations.swift
//  Swift Data Structures
//
//  Created by AARON FARBER on 4/11/16.
//  Copyright © 2016 Aaron Farber. All rights reserved.
//

import Foundation

extension BinarySearchTree {
    
    internal func leftRotate(node : TreeNode<Element>) -> TreeNode<Element> {
        
        let right = node.right!
        
        let temp = right.left
        
        right.left = node
        node.right = temp
        
        if root?.element == node.element { root = right }
        
        return right
    }
    
    internal func rightRotate(node : TreeNode<Element>) -> TreeNode<Element> {
        
        let left = node.left!
        
        let temp = left.right
        
        left.right = node
        node.left = temp
        
        if root!.element == node.element { root = left }
        
        return left
    }
}