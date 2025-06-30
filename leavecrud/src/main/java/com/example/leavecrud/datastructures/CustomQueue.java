package com.example.leavecrud.datastructures;

public class CustomQueue<T> {
    private static final int DEFAULT_CAPACITY = 10;
    private Object[] elements;
    private int front;
    private int rear;
    private int size;

    //constructor
    public CustomQueue() {
        elements = new Object[DEFAULT_CAPACITY];
        front = 0;
        rear = -1;
        size = 0;
    }

    //add an item to rear
    public void enqueue(T item) {
        if (size == elements.length) {
            expandCapacity();
        }
        rear = (rear + 1) % elements.length;
        elements[rear] = item;
        size++;

    }

    //remove the front item
    public T dequeue() {
        if (isEmpty()) {
            throw new IllegalStateException("Queue is empty");
        }
        @SuppressWarnings("unchecked")
        T item = (T) elements[front];
        elements[front] = null;
        front = (front + 1) % elements.length;
        size--;
        return item;
    }

    public T peek() {
        if (isEmpty()) {
            throw new IllegalStateException("Queue is empty");
        }
        @SuppressWarnings("unchecked")
        T item = (T) elements[front];
        return item;
    }

    public boolean isEmpty() {
        return size == 0;
    }

    //number if items
    public int size() {
        return size;
    }


    private void expandCapacity() {
        int newCapacity = elements.length * 2;
        Object[] newElements = new Object[newCapacity];

        for (int i = 0; i < size; i++) {
            int index = (front + i) % elements.length;
            newElements[i] = elements[index];
        }

        elements = newElements;
        front = 0;
        rear = size - 1;
    }

    //clear all items
    public void clear() {
        for (int i = 0; i < size; i++) {
            int index = (front + i) % elements.length;
            elements[index] = null;
        }
        front = 0;
        rear = -1;
        size = 0;
    }
}