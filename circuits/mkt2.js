function merkelize(F, hash, arr, nLevels) {
  const numberOfHashedElements = 1 << nLevels;

  const hArr = [];

  for (let i = 0; i < numberOfHashedElements; i++) {
    if (i < arr.length) {
      hArr.push(hash([F.e(arr[i])]));
    } else {
      hArr.push(F.zero);
    }
  }

  return __merkelize(hash, hArr);
}
