import Foundation

// MARK: - Add Two Numbers as Linked Lists

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    func addTwoNumbersR(_ l1: ListNode?, _ l2: ListNode?, _ carry: Int) -> ListNode? {
        var l1 = l1, l2 = l2
        var val: Int = (l1!.val ?? 0) + (l2!.val ?? 0) + carry 
        var carry: Int = val / 10 
        var ret = ListNode(val % 10)
        
        if l1!.next != nil || l2!.next != nil {
            if l1!.next == nil { l1!.next = ListNode(0) }
            if l2!.next == nil { l2!.next = ListNode(0) }
            
            ret.next = addTwoNumbersR(l1!.next, l2!.next, carry)
        } else if carry != 0 {
            ret.next = ListNode(carry)
        }
        return ret
    }
    
    func addTwoNumbersI(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var carry = 0, sum = 0
        let dummyHead = ListNode(0)
        var node = dummyHead 
        var l1 = l1, l2 = l2
        
        while l1 != nil || l2 != nil || carry != 0 {
            sum = carry
            
            if l1 != nil { 
                sum += l1!.val 
                l1 = l1!.next 
            }
            
            if l2 != nil {
                sum += l2!.val 
                l2 = l2!.next
            }
            
            carry = sum / 10
            node.next = ListNode(sum % 10)
            node = node.next!
        }
        return dummyHead.next
    }
    
    // return addTwoNumbersR(l1, l2, 0)
    return addTwoNumbersI(l1, l2)
}

// MARK: - Reverse Linked Lists 

/// Reverse linked list recursively
/// https://leetcode.com/problems/reverse-linked-list/
func reverseLinkedListRecursive(_ head: ListNode?) -> ListNode? {
    if head == nil || head!.next == nil { return head }
    let node = reverseLinkedListRecursive(head!.next)
    head!.next!.next = head
    head!.next = nil
    return node
}

/// Reverse linked list iteratively
/// https://leetcode.com/problems/reverse-linked-list/
func reverseLinkedListIterative(_ head: ListNode?) -> ListNode? {
    var temp: ListNode?, head = head
    
    while head != nil {
        (head, head!.next, temp) = (head!.next, temp, head)
    }
    return temp
}

// MARK: - Palindrome 

/// Checks if linked list is a palindrome
/// https://leetcode.com/problems/palindrome-linked-list/submissions/
func isPalindrome(_ head: ListNode?) -> Bool {
    var head = head
    var fast = head
    var slow = head
    
    while fast != nil && fast!.next != nil {
        fast = fast!.next!.next
        slow = slow!.next
    }
    
    var node: ListNode?
    while slow != nil {
        (node, slow!.next, slow) = (slow, node, slow!.next)
    }
    
    while node != nil {
        if head!.val != node!.val { return false }
        head = head!.next
        node = node!.next
    }
    return true
}

// MARK: - Delete Linked Lists 

/// Deletes duplicated nodes in the a linked lists
/// https://leetcode.com/problems/remove-duplicates-from-sorted-list-ii/
func deleteDuplicates(_ head: ListNode?) -> ListNode? {
    let dummy = ListNode(0)
    dummy.next = head
    var node = dummy
    
    while node.next != nil && node.next!.next != nil {
        if node.next!.val == node.next!.next!.val {
            let val = node.next!.val
            while node.next != nil && node.next!.val == val {
                node.next = node.next!.next
            }
        } else {
            node = node.next!
        }
    }
    return dummy.next
}

/// Deletes elements in linked lists
/// https://leetcode.com/problems/remove-linked-list-elements/
func removeLinkedListElements(_ head: ListNode?, _ val: Int) -> ListNode? {
    let dummy: ListNode? = ListNode(0)
    dummy!.next = head
    var next = dummy
    
    while next != nil && next!.next != nil {
        if next!.next!.val == val {
            next!.next = next!.next!.next
        } else {
            next = next!.next!
        }
    }
    return dummy!.next
}

// MARK: - Rotating

// 0-1-2-3-4-5-6-7-8-9 k == 2
// 8-9-0-1-2-3-4-5-6-7
/// Rotates a linked list k times
/// https://leetcode.com/problems/rotate-list/
func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
    if head == nil || head!.next == nil { return head }
    var head = head, node = head
    var len: Int = 1
    
    // get length of linked list 
    while node!.next != nil {
        node = node!.next
        len += 1
    }
    
    // determine how to rotate linked list 
    let i = k % len
    if i == 0 { return head }
    var fast = head, slow = head
    
    (0..<i).forEach { _ in fast = fast!.next }
    
    while fast!.next != nil {
        slow = slow!.next
        fast = fast!.next
    }
    
    // temp is new head, slow is new tail
    let temp = slow!.next
    slow!.next = nil
    
    // connect tail to head
    fast!.next = head
    head = temp
    
    return head
}

/// Deletes a node
func deleteLinkedList(_ node: ListNode?) {
    if node!.next != nil {
        node!.val = node!.next!.val
        node!.next = node!.next!.next
    }
}

/// List Node object
/// - Parameters:
///     - val: Int
///     - next: ListNode?
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
