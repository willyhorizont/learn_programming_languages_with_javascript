class Node:
    def __init__(self, data):
        self.data = data  # The data stored in the node
        self.next = None  # Reference to the next node, default is None

class LinkedList:
    def __init__(self):
        self.head = None  # Initialize the head of the list as None

    # Method to add a node at the end of the list
    def append(self, data):
        new_node = Node(data)
        if (self.head == None):  # If the list is empty, the new node becomes the head
            self.head = new_node
            return
        last_node = self.head
        while (last_node.next != None):  # Traverse to the last node
            last_node = last_node.next
        last_node.next = new_node  # Set the new node as the next of the last node

    # Method to display the linked list
    def display(self):
        nodes = []
        current_node = self.head
        while (current_node != None):  # Traverse through the list
            nodes.append(str(current_node.data))
            current_node = current_node.next
        print(" -> ".join(nodes))

    # Method to delete a node by value
    def delete(self, key):
        current_node = self.head

        # If the head contains the key
        if ((current_node != None) and (current_node.data == key)):
            self.head = current_node.next  # Move the head to the next node
            current_node = None  # Free the old head
            return

        # Traverse the list to find the node to be deleted
        previous_node = None
        while ((current_node != None) and (current_node.data != key)):
            previous_node = current_node
            current_node = current_node.next

        if (current_node is None):  # If the key is not found
            return

        previous_node.next = current_node.next  # Unlink the node from the list
        current_node = None

# Example usage:
my_linked_list_1 = LinkedList()
my_linked_list_1.append("a")
my_linked_list_1.append("b")
my_linked_list_1.append("c")
my_linked_list_1.display()  # Output: a -> b -> c

my_linked_list_1.delete("b")
my_linked_list_1.display()  # Output: a -> c
