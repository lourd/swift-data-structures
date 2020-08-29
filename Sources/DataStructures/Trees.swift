//
//  DATA STRUCTURES
//

class Node<T: Comparable> {
  var value: T
  var children: [Node<T>]

  init(_ value: T, children: [Node<T>] = []) {
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
  func isBinaryTree<T>(_ node: Node<T>?) -> Bool {
    guard let node = node else {
      return true
    }
    if node.children.count > 2 {
      return false
    }
    for child in node.children {
      if !isBinaryTree(child) {
        return false
      }
    }
    return true
    // alternative to for loop, a little more functional
    // return node.children.reduce(true, { result, child in result && isBinaryTree(child) })
  }
  return isBinaryTree(tree.root)
}

func isBinarySearchTree<T>(_ tree: Tree<T>) -> Bool {
  return false
}

func isBalancedBinarySearchTree<T>(_ tree: Tree<T>) -> Bool {
  return false
}

func balance<T>(_ tree: Tree<T>) {

}

func breadthFirstTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {
  guard let root = tree.root else {
    return
  }
  visit(root.value)
  var queue = root.children
  while !queue.isEmpty {
    let node = queue.removeFirst()
    visit(node.value)
    queue.append(contentsOf: node.children)
  }

  // alternative
  // var i = 0
  // while i < queue.count {
  //   let node = queue[i]
  //   visit(node.value)
  //   queue.append(contentsOf: node.children)
  //   i += 1
  // }
}

func depthFirstPreOrderTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {
  func depthFirstPreOrderTraversal<T>(_ node: Node<T>?, _ visit: ((T) -> Void)) {
    guard let node = node else {
      return
    }
    visit(node.value)
    for child in node.children {
      depthFirstPreOrderTraversal(child, visit)
    }
  }
  depthFirstPreOrderTraversal(tree.root!, visit)
}

func depthFirstInOrderTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {
  func depthFirstInOrderTraversal<T>(_ node: Node<T>?, _ visit: ((T) -> Void)) {
    guard let node = node else {
      return
    }
    depthFirstInOrderTraversal(node.children[safe: 0], visit)
    visit(node.value)
    depthFirstInOrderTraversal(node.children[safe: 1], visit)
  }
  depthFirstInOrderTraversal(tree.root, visit)
}

func depthFirstPostOrderTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {
  func depthFirstPostOrderTraversal<T>(_ node: Node<T>?, _ visit: ((T) -> Void)) {
    guard let node = node else {
      return
    }
    depthFirstPostOrderTraversal(node.children[safe: 0], visit)
    depthFirstPostOrderTraversal(node.children[safe: 1], visit)
    visit(node.value)
  }
  depthFirstPostOrderTraversal(tree.root, visit)
}

func prettyTreeString<T>(_ tree: Tree<T>) -> String {
  return ""
}
