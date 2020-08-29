//
//  DATA STRUCTURES
//

class Node<T: Comparable> {
  var value: T
  var children: [Node<T>]

  init(_ value: T, _ children: Node<T>...) {
    self.value = value
    self.children = children
  }
}

class Tree<T: Comparable> {
  var root: Node<T>?
  init(_ root: Node<T>? = nil) {
    self.root = root
  }
}

// Adds a way of succinct way to get a value in an array without accidentally
// going out of bounds.
extension Collection where Indices.Iterator.Element == Index {
  public subscript(safe index: Index) -> Iterator.Element? {
    return (startIndex <= index && index < endIndex) ? self[index] : nil
  }
}

//
// ALGORITHMS
//

func isBinaryTree<T>(_ tree: Tree<T>) -> Bool {
  return false
}

func isBinarySearchTree<T>(_ tree: Tree<T>) -> Bool {
  return false
}

func isBalancedBinarySearchTree<T>(_ tree: Tree<T>) -> Bool {
  return false
}

func getHeight<T>(_ tree: Tree<T>) -> Int {
  return 0
}

func getHeight<T>(_ node: Node<T>?) -> Int {
  return 0
}

func balance<T>(_ tree: Tree<T>) {

}

func breadthFirstTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {

}

func depthFirstPreOrderTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {

}

func depthFirstInOrderTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {

}

func depthFirstPostOrderTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {

}

func prettyTreeString<T>(_ tree: Tree<T>) -> String {
  return ""
}
