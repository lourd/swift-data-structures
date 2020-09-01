import XCTest

@testable import DataStructures

final class DataStructuresTests: XCTestCase {
  func testTreeEquality() {
    XCTAssertEqual(Tree<Int>(), Tree<Int>())
    XCTAssertEqual(Tree(Node(2)), Tree(Node(2)))
    XCTAssertNotEqual(Tree(Node(2)), Tree(Node(3)))
    XCTAssertNotEqual(Tree(Node(2)), Tree(Node(2, Node(3))))
  }

  func testIsBinaryTree() {
    XCTAssertTrue(isBinaryTree(t))
    XCTAssertFalse(isBinaryTree(t2))
  }

  func testIsBinarySearchTree() {
    XCTAssertTrue(isBinarySearchTree(t))
    XCTAssertFalse(isBinarySearchTree(t2))
    XCTAssertTrue(isBinarySearchTree(t3))
    XCTAssertFalse(isBinarySearchTree(t4))
    XCTAssertFalse(isBinarySearchTree(Tree<Int>()))
    XCTAssertTrue(isBinarySearchTree(t6))
  }

  func testIsBalancedBinarySearchTree() {
    XCTAssertTrue(isBalancedBinarySearchTree(t))
    XCTAssertFalse(isBalancedBinarySearchTree(t2))
    XCTAssertTrue(isBalancedBinarySearchTree(t3))
    XCTAssertFalse(isBalancedBinarySearchTree(t4))
    XCTAssertFalse(isBalancedBinarySearchTree(Tree<Int>()))
    XCTAssertFalse(isBalancedBinarySearchTree(t6))
  }

  func testGetHeight() {
    XCTAssertEqual(getHeight(t), 2)
    XCTAssertEqual(getHeight(t2), 2)
    XCTAssertEqual(getHeight(t3), 3)
    XCTAssertEqual(getHeight(t4), 2)
    XCTAssertEqual(getHeight(Tree<Int>()), 0)
    XCTAssertEqual(getHeight(t5), 5)
    XCTAssertEqual(getHeight(t6), 3)
  }

  func testGetNodeCount() {
    XCTAssertEqual(getNodeCount(t), 3)
    XCTAssertEqual(getNodeCount(t2), 4)
    XCTAssertEqual(getNodeCount(t3), 7)
    XCTAssertEqual(getNodeCount(t4), 3)
    XCTAssertEqual(getNodeCount(Tree<Int>()), 0)
    XCTAssertEqual(getNodeCount(t5), 6)
    XCTAssertEqual(getNodeCount(t6), 3)
  }

  func testBreadthFirstTraversal() {
    let expectation = [5, 3, 7, 2, 4, 6, 8]
    var reality: [Int] = []
    breadthFirstTraversal(t3, { value in reality.append(value) })
    XCTAssertEqual(reality, expectation)
  }

  func testPreOrderTraversal() {
    let expectation = [5, 3, 2, 4, 7, 6, 8]
    var reality: [Int] = []
    depthFirstPreOrderTraversal(t3, { value in reality.append(value) })
    XCTAssertEqual(reality, expectation)
  }

  func testInOrderTraversal() {
    let expectation = [2, 3, 4, 5, 6, 7, 8]
    var reality: [Int] = []
    depthFirstInOrderTraversal(t3, { value in reality.append(value) })
    XCTAssertEqual(reality, expectation)
  }

  func testPostOrderTraversal() {
    let expectation = [2, 4, 3, 6, 8, 7, 5]
    var reality: [Int] = []
    depthFirstPostOrderTraversal(t3, { value in reality.append(value) })
    XCTAssertEqual(reality, expectation)
  }

  func testTreeToVine() {
    let tree = Tree(
      Node(
        5,
        Node(
          3,
          Node(2),
          Node(4)
        ),
        Node(
          7,
          Node(6),
          Node(8)
        )
      )
    )
    XCTAssertEqual(treeToVine(tree), rightChildTree)
  }

  func testVineToTree() {
    let tree = Tree(
      Node(
        2,
        nil,
        Node(
          3,
          nil,
          Node(
            4,
            nil,
            Node(
              5,
              nil,
              Node(
                6,
                nil,
                Node(
                  7,
                  nil,
                  Node(8)))))))
    )
    XCTAssertEqual(vineToTree(tree), balancedRightChildTree)
    XCTAssertEqual(vineToTree(Tree(Node(1))), Tree(Node(1)))
    XCTAssertEqual(vineToTree(Tree(Node(1, nil, Node(2)))), Tree(Node(1, nil, Node(2))))
  }

  func testBalanceBinarySearchTree() {
    let tree = Tree(
      Node(
        1,
        nil,
        Node(
          2,
          nil,
          Node(3)))
    )
    XCTAssertEqual(balanceBinarySearchTree(tree), t)

    let tree2 = Tree(
      Node(
        5,
        Node(
          1,
          Node(0),
          Node(
            3,
            nil,
            Node(4)
          )
        ),
        Node(7)
      )
    )
    XCTAssertEqual(balanceBinarySearchTree(tree2), t7)

    let rightChildChain = Tree(
      Node(
        2,
        nil,
        Node(
          3,
          nil,
          Node(
            4,
            nil,
            Node(
              5,
              nil,
              Node(
                6,
                nil,
                Node(
                  7,
                  nil,
                  Node(8)))))))
    )
    XCTAssertEqual(balanceBinarySearchTree(rightChildChain), balancedRightChildTree)
  }
}

//
//  TEST FIXTURES
//

let t = Tree(
  Node(
    2,
    Node(1),
    Node(3)
  )
)

let t2 = Tree(
  Node(
    1,
    Node(2),
    Node(3),
    Node(4)
  )
)

let t3 = Tree(
  Node(
    5,
    Node(
      3,
      Node(2),
      Node(4)
    ),
    Node(
      7,
      Node(6),
      Node(8)
    )
  )
)

let t4 = Tree(
  Node(
    2,
    Node(3),
    Node(1)
  )
)

let t5 = Tree(
  Node(
    1,
    Node(
      2,
      Node(
        3,
        Node(
          4,
          Node(5)))),
    Node(6)
  )
)

let t6 = Tree(
  Node(
    1,
    nil,
    Node(
      2,
      nil,
      Node(3)))
)

let t7 = Tree(
  Node(
    3,
    Node(
      1,
      Node(0)
    ),
    Node(
      5,
      Node(4),
      Node(7)
    )
  )
)

let rightChildTree = Tree(
  Node(
    2,
    nil,
    Node(
      3,
      nil,
      Node(
        4,
        nil,
        Node(
          5,
          nil,
          Node(
            6,
            nil,
            Node(
              7,
              nil,
              Node(8)))))))
)

let balancedRightChildTree = Tree(
  Node(
    5,
    Node(
      3,
      Node(2),
      Node(4)
    ),
    Node(
      7,
      Node(6),
      Node(8)
    )
  )
)
