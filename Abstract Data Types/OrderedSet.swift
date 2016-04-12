//
//  OrderedSet.swift
//  Swift Data Structures
//
//  Created by AARON FARBER on 4/11/16.
//  Copyright © 2016 Aaron Farber. All rights reserved.
//

import Foundation

public struct OrderedSet<Element : Comparable> {
    
    // MARK: - Public Variables
    
    public var count : Int { return tree.count }
    public var isEmpty : Bool { return tree.isEmpty }
    public var description : String  { return tree.description }
    
    // MARK: - Private Variables
    
    private var tree : AVLTree<Element>!
    
    // MARK: - Initializers
    
    public init(arrayLiteral : Element ...) {
        tree = AVLTree<Element>(arrayLiteral: arrayLiteral)
    }
    
    // MARK: - Element Insertion
    
    public mutating func insert(item : Element) {
        
        tree.insert(item)
    }
    
    // MARK: - Element Search
    
    public mutating  func contains(element: Element) -> Bool {
        
        return tree.contains(element)
    }
    
    // MARK: - Element Removal
    
    public mutating func remove(item : Element) {
        
        return tree.remove(item)
    }
}


// MARK: - Operator Overloads

public func +=<Element : Comparable>(inout left : OrderedSet<Element>, right: Element) {
    left.insert(right)
}