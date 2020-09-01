//
//  DATA STRUCTURES
//

class Node<T: Comparable>: Equatable {
  var value: T
  var children: [Int: Node<T>] = [:]

  init(_ value: T, _ children: Node<T>?...) {
    self.value = value
    for i in 0..<children.count {
      guard let child = children[i] else {
        continue
      }
      self.children[i] = child
    }
  }

  var leftChild: Node<T>? {
    get { return self.children[0] }
    set { self.children[0] = newValue }
  }

  var rightChild: Node<T>? {
    get { return self.children[1] }
    set { self.children[1] = newValue }
  }

  static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
    return lhs.value == rhs.value && lhs.children == rhs.children
  }
}

class Tree<T: Comparable>: Equatable {
  static func == (lhs: Tree<T>, rhs: Tree<T>) -> Bool {
    return lhs.root == rhs.root
  }

  var root: Node<T>?
  init(_ root: Node<T>? = nil) {
    self.root = root
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

func getNodeCount<T>(_ tree: Tree<T>) -> Int {
  return 0
}

func getNodeCount<T>(_ node: Node<T>?) -> Int {
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

@discardableResult func balanceBinarySearchTree<T>(_ tree: Tree<T>) -> Tree<T> {
  return tree
}
