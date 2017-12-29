import Foundation

//MARK: - Node
public class Node<T : Comparable> {
    var data : T
    fileprivate var leftChild : Node<T>?
    fileprivate var rightChild : Node?
    
    init(data : T, leftChild : Node<T>?, rightChild : Node<T>?) {
        self.data = data
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

//MARK: - Binary Search Tree
public struct BinarySearchTree<T : Comparable> : ExpressibleByArrayLiteral, CustomStringConvertible {
    public var root : Node<T>?
    
    public init(arrayLiteral: T...) {
        if arrayLiteral.count > 0 {
            root = Node(data : arrayLiteral[0], leftChild : nil, rightChild : nil)
        }
        
        guard arrayLiteral.count > 1 else {
            return
        }
        
        for index in 1 ..< arrayLiteral.count {
            _ = self.insert(data: arrayLiteral[index], node: root)
        }
    }
    
    public mutating func insert(data : T, node : Node<T>? = nil) -> Node<T>? {
        var currentNode = node
        
        //when passed tree is EMPTY
        guard currentNode != nil else {
            currentNode = Node(data : data, leftChild : nil, rightChild : nil)
            return currentNode!
        }
        
        //when passed tree is NON-EMPTY
        //Data in current node has same value for which insertion is performed
        if currentNode!.data == data {
            currentNode!.leftChild = Node(data : data, leftChild : currentNode!.leftChild, rightChild : nil)
            return currentNode!
        }
            //Data in current node has Larger Value for which insertion is performed
        else if currentNode!.data > data {
            if currentNode!.leftChild == nil {
                currentNode!.leftChild = insert(data: data, node: currentNode!.leftChild)
            }
            else{
                _ = insert(data: data, node: currentNode!.leftChild)
            }
        }
            //Data in current node has Smaller Value for which insertion is performed
        else if currentNode!.data < data {
            if currentNode!.rightChild == nil {
                currentNode!.rightChild = insert(data: data, node: currentNode!.rightChild)
            }
            else{
                _ = insert(data: data, node: currentNode!.rightChild)
            }
        }
        
        return currentNode
    }
    
    public var description : String {
        return preOrderTraversal(node: self.root) ?? "EMPTY"
    }
}

//MARK: - Binary Search Tree Operation extension
public extension BinarySearchTree {
    func preOrderTraversal(node : Node<T>? = nil) -> String? {
        guard node != nil else {
            return nil
        }
        
        if node!.leftChild == nil && node!.rightChild == nil {
            return "\(node!.data)"
        }
        
        return "\(node!.data){\(preOrderTraversal(node: node!.leftChild) ?? ""), \(preOrderTraversal(node: node!.rightChild) ?? "")}"
    }
    
    func inOrderTraversal(node : Node<T>? = nil) -> String? {
        guard node != nil else {
            return nil
        }
        
        if node!.leftChild == nil && node!.rightChild == nil {
            return "\(node!.data)"
        }
        
        return "\(inOrderTraversal(node: node!.leftChild) ?? "") \(node!.data) \(inOrderTraversal(node: node!.rightChild) ?? "")"
    }
    
    func postOrderTraversal(node : Node<T>? = nil) -> String? {
        guard node != nil else {
            return nil
        }
        
        if node!.leftChild == nil && node!.rightChild == nil {
            return "\(node!.data)"
        }
        
        return "{\(postOrderTraversal(node: node!.leftChild) ?? ""), \(postOrderTraversal(node: node!.rightChild) ?? "")}\(node!.data)"
    }
}
