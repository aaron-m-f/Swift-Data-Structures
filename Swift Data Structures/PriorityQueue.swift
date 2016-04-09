//
//  PriorityQueue.swift
//  
//
//  Created by AARON FARBER on 4/8/16.
//
//

import Foundation

public struct PriorityQueue<Element : Comparable> {
    
    // MARK: - Public Variables

    public var count : Int { return heap.count }
    public var isEmpty : Bool { return heap.isEmpty }
    public var top : Element? { return heap.top }
    public var description : String  { return heap.description }
    
    // MARK: - Private Variables

    private var heap : Heap<Element>!
    
    // MARK: - Initializers
    
    public init() {
        heap = Heap<Element>()
    }
    
    public init(comparison : (Element, Element) -> Bool ) {
        heap = Heap<Element>(comparison: comparison)
    }
    
    // MARK: - Convenience Initializers
    
    public init(minMaxType : MinMaxType) {
        heap = Heap<Element>(minMaxType: minMaxType)
    }
    
    public init(array : [Element], minMaxType : MinMaxType = .Min) {
        heap = Heap<Element>(array: array, minMaxType: minMaxType)
    }
    
    public init(array : [Element], comparison : (Element, Element) -> Bool) {
        heap = Heap<Element>(array: array, comparison: comparison)
    }
    
    // MARK: - Element Insertion
    
    public mutating func enqueue(item : Element) {
        
        heap.insert(item)
    }
    
    // MARK: - Element Removal
    
    public mutating func dequeue() -> Element? {
        
        return heap.getTopAndPop()
    }
}

// MARK: - Operator Overloads

public func +=<Element : Comparable>(inout left : PriorityQueue<Element>, right: Element) {
    left.enqueue(right)
}