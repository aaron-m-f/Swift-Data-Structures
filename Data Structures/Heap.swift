//
//  Heap.swift
//  
//
//  Created by AARON FARBER on 4/8/16.
//
//

import Foundation

public enum MinMaxType {
    case Min, Max
}

public struct Heap<Element : Comparable> : CustomStringConvertible {
    
    // MARK: - Public Variables
    
    public var count : Int { return heap.count }
    public var isEmpty : Bool { return heap.isEmpty }
    public var top : Element? { return heap.first }
    public var description : String  { return heap.description }
    
    // MARK: - Private Variables
    
    private var heap = [Element]()
    private let isOrdered : ((Element, Element) -> Bool)!
    
    // MARK: - Initializers
    
    public init() {
        isOrdered = { $0 < $1 }
    }
    
    public init(comparison : (Element, Element) -> Bool ) {
        isOrdered = comparison
    }
    
    // MARK: - Convenience Initializers
    
    public init(minMaxType : MinMaxType) {
        
        switch minMaxType {
        case .Max:
            self.init(comparison: { $0 > $1 })
        default:
            self.init(comparison: { $0 < $1 })
        }
    }
    
    public init(array : [Element], minMaxType : MinMaxType = .Min) {
        self.init(minMaxType: minMaxType)
        
        heapify(array)
    }
    
    public init(array : [Element], comparison : (Element, Element) -> Bool) {
        self.init(comparison: comparison)
        
        heapify(array)
    }
    
    // MARK: - Element Insertion
    
    public mutating func insert(item : Element) {
        
        heap.append(item)
        shiftUp()
    }
    
    // MARK: - Element Removal
    
    public mutating func pop() {
        
        if let last = heap.last {
            heap[heap.startIndex] = last
            heap.removeLast()
            
            shiftDown(heap.startIndex)
        }
    }
    
    public mutating func getTopAndPop() -> Element? {
        
        if let top = heap.first {
            pop()
            return top
        }
        
        return nil
    }
    
    public mutating func replace(element : Element) -> Element? {
        
        if let top = heap.first {
            heap[heap.startIndex] = element
            
            shiftDown(heap.startIndex)
            return top
        }
        
        heap.append(element)
        return nil
    }
    
    // MARK: - Element Sorting
    
    public func sorted() -> [Element] {
        var sorted = [Element]()
        
        var tempHeap = self
        while let element = tempHeap.getTopAndPop() {
            sorted.append(element)
        }
        
        return sorted
    }
    
    // MARK: - Shifting Elements
    
    private mutating func shiftUp() {
        var index = heap.endIndex - 1
        
        while let parentIndex = parentIndex(index) where isOrdered(heap[index], heap[parentIndex]) {
            swap(&heap[parentIndex], &heap[index])
            index = parentIndex
        }
    }
    
    private mutating func shiftDown(startIndex : Int) {
        var index = startIndex
        
        while let childIndex = childToSwapIndex(index) { // IMPLICIT: where isOrdered(heap[childIndex], heap[index])
            swap(&heap[index], &heap[childIndex])
            index = childIndex
        }
    }
    
    // MARK: - Array Heapifying
    
    private mutating func heapify(array : [Element]) {
        
        heap = array
        
        /*
         *   Since the last half of items in any heap are leaves (due binary trees growing at 2^N), we can build a heap
         *   from the bottom up by only shifting the elements before the midpoint
         */
        for index in (heap.startIndex..<(heap.endIndex / 2)).reverse() {
            shiftDown(index)
        }
    }
    
    // MARK: - Element Indicies
    
    private func parentIndex(index : Int) -> Int? {
        
        switch index {
        case 0: return nil
        default: return (index - 1) / 2
        }
    }
    
    private func childToSwapIndex(index : Int) -> Int? {
        
        let leftChildIndex = (index * 2) + 1
        let rightChildIndex = (index * 2) + 2
        
        let hasLeftChild : Bool = leftChildIndex < count
        let hasRightChild : Bool = rightChildIndex < count
        
        if !hasLeftChild && !hasRightChild { return nil }
        
        let leftChild = hasLeftChild ? heap[leftChildIndex] : heap[index]
        let rightChild = hasRightChild ? heap[rightChildIndex] : heap[index]
        
        if isOrdered(leftChild, heap[index]) && !isOrdered(rightChild, leftChild) { return leftChildIndex }
        if isOrdered(rightChild, heap[index]) && !isOrdered(leftChild, rightChild) { return rightChildIndex }
        
        return nil
    }
}

// MARK: - Operator Overloads

public func +=<Element : Comparable>(inout left : Heap<Element>, right: Element) {
    left.insert(right)
}