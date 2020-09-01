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
  if tree.root == nil {
    return false
  }
  func isBinarySearchTree<T>(_ node: Node<T>?) -> Bool {
    guard let node = node else {
      return true
    }
    if node.children.count > 2 {
      return false
    }
    let leftChild = node.children[safe: 0]
    if let leftChild = leftChild {
      if !(leftChild.value < node.value) {
        return false
      }
    }
    let rightChild = node.children[safe: 1]
    if let rightChild = rightChild {
      if !(rightChild.value > node.value) {
        return false
      }
    }
    return isBinarySearchTree(leftChild) && isBinarySearchTree(rightChild)
  }
  return isBinarySearchTree(tree.root)
}

func isBalancedBinarySearchTree<T>(_ tree: Tree<T>) -> Bool {
  return false
}

func getHeight<T>(_ tree: Tree<T>) -> Int {
  return getHeight(tree.root)
}

func getHeight<T>(_ node: Node<T>?) -> Int {
  guard let node = node else {
    return 0
  }
  let maxChildHeight = node.children.map(getHeight).max() ?? 0
  return 1 + maxChildHeight
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
