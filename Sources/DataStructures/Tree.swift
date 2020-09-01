import Foundation

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
// TREE CLASSIFYING ALGORITHMS
//

func isBinaryTree<T>(_ tree: Tree<T>) -> Bool {
  func isBinaryTree<T>(_ node: Node<T>?) -> Bool {
    guard let node = node else {
      return true
    }
    if node.children.count > 2 {
      return false
    }
    for (_, child) in node.children {
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
    let leftChild = node.leftChild
    if let leftChild = leftChild {
      if !(leftChild.value < node.value) {
        return false
      }
    }
    let rightChild = node.rightChild
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
  guard isBinarySearchTree(tree) else {
    return false
  }
  guard let root = tree.root else {
    return false
  }
  let leftHeight = getHeight(root.leftChild)
  let rightHeight = getHeight(root.rightChild)
  return abs(leftHeight - rightHeight) <= 1
}

//
//  TREE DATA COMPUTING FUNCTIONS
//

func getHeight<T>(_ tree: Tree<T>) -> Int {
  return getHeight(tree.root)
}

func getHeight<T>(_ node: Node<T>?) -> Int {
  guard let node = node else {
    return 0
  }
  let maxChildHeight = node.children.compactMap { getHeight($1) }.max() ?? 0
  return 1 + maxChildHeight
}

func getNodeCount<T>(_ tree: Tree<T>) -> Int {
  return getNodeCount(tree.root)
}

func getNodeCount<T>(_ node: Node<T>?) -> Int {
  guard let node = node else {
    return 0
  }
  return node.children.reduce(1) { count, item in count + getNodeCount(item.value) }
}

func getBalanceFactor<T>(_ node: Node<T>) -> Int {
  return getHeight(node.rightChild) - getHeight(node.leftChild)
}

//
// TRAVERSAL FUNCTIONS
//

func breadthFirstTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {
  guard let root = tree.root else {
    return
  }
  visit(root.value)
  var queue = root.children.sorted(by: { $0.key < $1.key })
  while !queue.isEmpty {
    let (_, node) = queue.removeFirst()
    visit(node.value)
    queue.append(contentsOf: node.children.sorted(by: { $0.key < $1.key }))
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
    for (_, child) in node.children.sorted(by: { $0.key < $1.key }) {
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
    depthFirstInOrderTraversal(node.leftChild, visit)
    visit(node.value)
    depthFirstInOrderTraversal(node.rightChild, visit)
  }
  depthFirstInOrderTraversal(tree.root, visit)
}

func depthFirstPostOrderTraversal<T>(_ tree: Tree<T>, _ visit: ((T) -> Void)) {
  func depthFirstPostOrderTraversal<T>(_ node: Node<T>?, _ visit: ((T) -> Void)) {
    guard let node = node else {
      return
    }
    depthFirstPostOrderTraversal(node.leftChild, visit)
    depthFirstPostOrderTraversal(node.rightChild, visit)
    visit(node.value)
  }
  depthFirstPostOrderTraversal(tree.root, visit)
}

func prettyTreeString<T>(_ tree: Tree<T>) -> String {
  return ""
}

//
//  TREE BALANCING & MANIPULATION FUNCTIONS
//

func rotateLeft<T>(_ node: Node<T>) -> Node<T> {
  guard let newParent = node.rightChild else {
    return node
  }
  node.rightChild = newParent.leftChild
  newParent.leftChild = node
  return newParent
}

func rotateRight<T>(_ node: Node<T>) -> Node<T> {
  guard let newParent = node.leftChild else {
    return node
  }
  node.leftChild = newParent.rightChild
  newParent.rightChild = node
  return newParent
}

@discardableResult func balanceBinarySearchTree<T>(_ tree: Tree<T>) -> Tree<T> {
  guard let root = tree.root else {
    return tree
  }
  guard isBinarySearchTree(tree) else {
    return tree
  }
  func oneOffBalance<T>(_ node: Node<T>) -> Node<T> {
    let balanceFactor = getBalanceFactor(node)
    guard abs(balanceFactor) == 2 else {
      return node
    }
    if balanceFactor == -2 {
      let childBalanceFactor = getBalanceFactor(node.leftChild!)
      if childBalanceFactor > 0 {
        node.leftChild = rotateLeft(node.leftChild!)
      }
      return rotateRight(node)
    } else if balanceFactor == 2 {
      let childBalanceFactor = getBalanceFactor(node.rightChild!)
      if childBalanceFactor < 0 {
        node.rightChild = rotateRight(node.rightChild!)
      }
      return rotateLeft(node)
    }
    return node
  }
  ///
  /// The Day–Stout–Warren algorithm
  ///
  func fullRebalance<T>(_ tree: Tree<T>) {
    treeToVine(tree)
    vineToTree(tree)
  }
  let balanceFactor = abs(getBalanceFactor(root))
  guard balanceFactor > 1 else {
    // Already balanced
    return tree
  }
  guard balanceFactor > 2 else {
    // Only off balance by insertion, do some rotations to re-balance
    tree.root = oneOffBalance(root)
    return tree
  }
  // Off balance by any number, do a full tree re-shaping
  fullRebalance(tree)
  return tree
}

/// Turns the tree into a right child "vine"
@discardableResult func treeToVine<T>(_ tree: Tree<T>) -> Tree<T> {
  // Recursive version
  func treeToVine<T>(_ node: Node<T>?) -> Node<T>? {
    // Base case - the node is nil
    guard let parent = node else {
      return node
    }
    if parent.leftChild == nil {
      parent.rightChild = treeToVine(parent.rightChild)
      return parent
    }
    let newParent = rotateRight(parent)
    return treeToVine(newParent)
  }
  tree.root = treeToVine(tree.root)

  // Iterative version
  // var grandParent: Node<T>?
  // var parent = tree.root
  // while parent != nil {
  //   if parent!.leftChild == nil {
  //     grandParent = parent
  //     parent = parent!.rightChild
  //     continue
  //   }
  //   let newParent = rotateRight(parent!)
  //   if parent === tree.root {
  //     tree.root = newParent
  //   } else {
  //     grandParent!.rightChild = newParent
  //   }
  //   parent = newParent
  // }

  return tree
}

@discardableResult func vineToTree<T>(_ tree: Tree<T>) -> Tree<T> {
  let nodeCount = getNodeCount(tree)
  guard var root = tree.root, nodeCount > 2 else {
    return tree
  }
  var bottomRowLeaves = nodeCount + 1 - Int(log2(Float(nodeCount + 1)).rounded(.up))
  func makeRotations<T>(_ root: Node<T>, _ rotations: Int) -> Node<T> {
    var parent = root
    var newRoot: Node<T>?
    for i in 0..<rotations {
      if i == 0 {
        parent = rotateLeft(parent)
        newRoot = parent
      } else {
        parent.rightChild = rotateLeft(parent.rightChild!)
        parent = parent.rightChild!
      }
    }
    return newRoot!
  }
  root = makeRotations(root, nodeCount - bottomRowLeaves)
  while bottomRowLeaves > 2 {
    bottomRowLeaves /= 2
    root = makeRotations(root, bottomRowLeaves)
  }
  tree.root = root
  return tree
}
