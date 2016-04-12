//
//  BinarySearchTree.swift
//  Swift Data Structures
//
//  Created by AARON FARBER on 4/11/16.
//  Copyright © 2016 Aaron Farber. All rights reserved.
//

import Foundation

// MARK: - Tree Node

private class TreeNode<Element : Comparable> {
    
    var element : Element
    
    var left : TreeNode<Element>?
    var right : TreeNode<Element>?
    
    init(element : Element, left : TreeNode? = nil, right : TreeNode? = nil) {
        self.element = element
        self.left = left
        self.right = right
    }
}

class BinarySearchTree<Element : Comparable> : CustomStringConvertible, SequenceType {
    
    // MARK: - Public Variables
    
    var count = 0
    var isEmpty : Bool { return count == 0 }
    var description : String { return inOrderTraversal(root).description }
    
    // MARK: - Private Variables
    
    private var root : TreeNode<Element>? = nil
    
    // MARK: - Initializers
    
    init(arrayLiteral : Element ...) {
        
        for element in arrayLiteral {
            insert(element)
        }
    }
    
    // MARK: - Sequence Type
    
    func generate() -> AnyGenerator<Element> {
        var stack = [TreeNode<Element>]()
        
        if let root = root {
            stack.append(root)
            getLeftTail(root)
            stack.insertContentsOf(getLeftTail(root), at: 0)
        }
        
        return AnyGenerator {
            while let current = stack.first {
                
                if let right = current.right {
                    stack[0] = right
                    stack.insertContentsOf(self.getLeftTail(right), at: 0)
                    return current.element
                } else {
                    stack.removeFirst()
                    return current.element
                }
            }
            
            return nil
        }
    }
    
    private func getLeftTail(node : TreeNode<Element>) -> [TreeNode<Element>] {
        var node = node
        var nodes = [TreeNode<Element>]()
        
        while let left = node.left {
            nodes.insert(left, atIndex: 0)
            node = left
        }
        
        return nodes
    }
    
    // MARK: - Element Insertion
    
    func insert(element : Element) {
        
        if let root = root {
            binaryInsert(element, node: root)
        } else {
            root = TreeNode<Element>(element: element)
            count = 1
        }
    }
    
    private func binaryInsert(element : Element, node : TreeNode<Element>?) -> TreeNode<Element>? {
        
        guard let node = node else {
            self.count += 1
            return TreeNode(element: element)
        }
        
        if element < node.element {
            node.left = binaryInsert(element, node: node.left)
        } else if element > node.element {
            node.right = binaryInsert(element, node: node.right)
        }
        
        return node
    }
    
    // MARK: - Element Find
    
    func contains(element: Element) -> Bool {
        return binarySearch(element, node: root)
    }
    
    private func binarySearch(element : Element, node : TreeNode<Element>?) -> Bool {
        
        guard let node = node else {
            return false
        }
        
        if element < node.element {
            return binarySearch(element, node: node.left)
        } else if element > node.element {
            return binarySearch(element, node: node.right)
        }
        
        return true
    }
    
    
    // MARK: - Element Deletion
    
    func remove(element : Element) {
        root = binaryErase(element, node: root)
    }
    
    private func binaryErase(element : Element, node : TreeNode<Element>?) -> TreeNode<Element>? {
        
        guard let node = node else { return nil }
        
        if element == node.element {
            return self.eraseNode(node)
        } else if element < node.element {
            node.left = binaryErase(element, node: node.left)
        } else if element > node.element {
            node.right = binaryErase(element, node: node.right)
        }
        
        return node
    }
    
    private func eraseNode(node : TreeNode<Element>) -> TreeNode<Element>? {
        
        self.count -= 1
        if let _ = node.left, right = node.right {
            
            var next = right
            node.right = self.getSuccessor(right, next: &next)
            node.element = next.element
            return node
            
        } else if let left = node.left {
            return left
        } else if let right = node.right {
            return right
        } else {
            return nil
        }
    }
    
    private func getSuccessor(node : TreeNode<Element>, inout next : TreeNode<Element>) -> TreeNode<Element>? {
        
        if let left = node.left {
            node.left = getSuccessor(left, next: &next)
            return node
        } else {
            next = node
            return node.right
        }
    }
    
    // MARK: - Description
    
    private func inOrderTraversal(node : TreeNode<Element>?) -> [Element] {
        
        var array = [Element]()
        
        if let node = node {
            array += inOrderTraversal(node.left)
            array.append(node.element)
            array += inOrderTraversal(node.right)
        }
        
        return array
    }
}