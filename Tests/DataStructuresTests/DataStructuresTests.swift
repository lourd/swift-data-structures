import XCTest

@testable import DataStructures

final class DataStructuresTests: XCTestCase {
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
  }

  func testGetHeight() {
    XCTAssertEqual(getHeight(t), 2)
    XCTAssertEqual(getHeight(t2), 2)
    XCTAssertEqual(getHeight(t3), 3)
    XCTAssertEqual(getHeight(t4), 2)
    XCTAssertEqual(getHeight(Tree<Int>()), 0)
    XCTAssertEqual(getHeight(t5), 5)
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
