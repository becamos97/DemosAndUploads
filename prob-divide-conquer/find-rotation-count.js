function findRotationCount(arr, low = 0, high = arr.length - 1) {
    if (high < low) return 0;
    if (high === low) return low;
    let mid = Math.floor((low + high) / 2)

    // Check if element (mid+1) is minimum element.
    if (mid < high && arr[mid + 1] < arr[mid])
        return mid + 1;

  // Check if mid is minimum element
    if (mid > low && arr[mid] < arr[mid - 1]) {
        return mid;
    }

    // Decide whether we need to go to left half or
    // right half
    if (arr[high] > arr[mid]) {
        return findRotationCount(arr, low, mid - 1);
    }

    return findRotationCount(arr, mid + 1, high);
}
  


module.exports = findRotationCount