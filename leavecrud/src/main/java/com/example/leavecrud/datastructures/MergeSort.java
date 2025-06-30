package com.example.leavecrud.datastructures;

import java.util.Comparator;
import java.util.List;

public class MergeSort {

    /**
     * Sorts a list using merge sort algorithm
     * @param <T> The type of elements in the list
     * @param list The list to be sorted
     * @param comparator The comparator to determine the order of elements
     */


    public static <T> void sort(List<T> list, Comparator<T> comparator) {
        if (list.size() > 1) {
            int mid = list.size() / 2;

            // Create new sublists to avoid modifying the original during merge
            List<T> left = new java.util.ArrayList<>(list.subList(0, mid));
            List<T> right = new java.util.ArrayList<>(list.subList(mid, list.size()));

            sort(left, comparator);
            sort(right, comparator);

            merge(list, left, right, comparator);
        }
    }


    private static <T> void merge(List<T> list, List<T> left, List<T> right, Comparator<T> comparator) {
        int i = 0, j = 0, k = 0;

        while (i < left.size() && j < right.size()) {
            if (comparator.compare(left.get(i), right.get(j)) <= 0) {
                list.set(k++, left.get(i++));
            } else {
                list.set(k++, right.get(j++));
            }
        }

        while (i < left.size()) {
            list.set(k++, left.get(i++));
        }

        while (j < right.size()) {
            list.set(k++, right.get(j++));
        }
    }
}


