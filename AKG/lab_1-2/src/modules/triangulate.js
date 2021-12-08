function getTrianglesFromPolygon(numOfCorners) {
  const res = [];
  let arrNum = new Array(numOfCorners).fill(0).map((_, i) => i);
  let currentPos = 0;
  for (let i = 0; i < numOfCorners - 2; ++i) {
    const { length } = arrNum;
    res.push([
      arrNum[currentPos % length],
      arrNum[(currentPos + 1) % length],
      arrNum[(currentPos + 2) % length],
    ]);
    currentPos = (currentPos + 1) % length;
    // eslint-disable-next-line no-loop-func
    arrNum = arrNum.filter((_, pos) => pos !== currentPos);
  }
  return res;
}

export function triangulate(fArray) {
  if (fArray.length > 0 && fArray[0].length > 3) {
    const newFArray = [];
    fArray?.forEach((f) => {
      const polToTriangle = getTrianglesFromPolygon(f.length);
      polToTriangle?.forEach((positions) => {
        newFArray.push([f[positions[0]], f[positions[1]], f[positions[2]]]);
      });
    });
    return newFArray;
  }
  return fArray;
}
