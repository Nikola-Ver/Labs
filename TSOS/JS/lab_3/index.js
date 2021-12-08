import {
  GetBoxBlurMatrix,
  GetGaussianMatrix,
  Sobel3x3Horizontal,
  Sobel3x3Vertical,
} from './Matrix.js';

const select = document.getElementById('filter');
const fileInput = document.getElementById('file_input');

let file = undefined;

const canvasRef = document.getElementById('canvas');
const processedCanvas = document.getElementById('processed-canvas');

var ctx = canvasRef.getContext('2d');

fileInput.onchange = function onChangeFile() {
  const fr = new FileReader();
  fr.onload = function onLoadFile() {
    file = this.result;
    const img = new Image();
    img.src = file;
    img.addEventListener('load', () => {
      canvasRef.height = img.height;
      canvasRef.width = img.width;
      ctx.drawImage(img, 0, 0);
      start();
    });
  };
  fr.readAsDataURL(this.files[0]);
};

function start() {
  const imageArray = ctx.getImageData(0, 0, canvasRef.width, canvasRef.height);

  const { matrix: boxMatrix, sum: boxSum } = GetBoxBlurMatrix(10);

  let result = undefined;

  switch (select.value) {
    case 'box':
      const boxBlurFiltered = convolutionFilter({
        sourceBitmap: imageArray.data,
        height: canvasRef.height,
        width: canvasRef.width,
        filterMatrix: boxMatrix,
        factor: boxSum,
      });
      result = boxBlurFiltered;
      break;
    case 'gauss':
      const { matrix: gaussMatrix, sum } = GetGaussianMatrix(5);

      const gaussFiltered = convolutionFilter({
        sourceBitmap: imageArray.data,
        height: canvasRef.height,
        width: canvasRef.width,
        filterMatrix: gaussMatrix,
        factor: sum,
      });
      result = gaussFiltered;
      break;
    case 'median':
      const medianFiltered = medianFilter({
        sourceBitmap: imageArray.data,
        height: canvasRef.height,
        width: canvasRef.width,
        matrixSize: 5,
      });
      result = medianFiltered;
      break;
    case 'sobel':
      const xFilterMatrix = Sobel3x3Horizontal;
      const yFilterMatrix = Sobel3x3Vertical;

      const sobelFiltered = ConvolutionFilterForSobel({
        sourceBitmap: imageArray.data,
        xFilterMatrix,
        yFilterMatrix,
        grayscale: true,
        height: canvasRef.height,
        width: canvasRef.width,
      });
      result = sobelFiltered;
      break;
  }

  result = Uint8ClampedArray.from(result);
  const processedCtx = processedCanvas.getContext('2d');
  const imageData = new ImageData(result, canvasRef.width);

  processedCanvas.height = canvasRef.height;
  processedCanvas.width = canvasRef.width;
  processedCtx.putImageData(imageData, 0, 0);
}

function medianFilter({ sourceBitmap, matrixSize, height, width }) {
  const pixelBuffer = [...sourceBitmap];
  const resultBuffer = new Array(sourceBitmap.length);
  const filterOffset = Math.floor((matrixSize - 1) / 2);
  const neighborPixels = [[], [], [], []];
  const bitmapHeight = height;
  const bitmapWidth = width;
  const bitmapWidthX4 = bitmapWidth * 4;
  for (let offsetY = 0; offsetY < bitmapHeight; offsetY++) {
    for (let offsetX = 0; offsetX < bitmapWidth; offsetX++) {
      let byteOffset = offsetY * bitmapWidthX4 + offsetX * 4;
      for (let filterY = -filterOffset; filterY <= filterOffset; filterY++) {
        for (let filterX = -filterOffset; filterX <= filterOffset; filterX++) {
          let calcOffset = byteOffset + filterX * 4 + filterY * bitmapWidthX4;
          if (filterY + offsetY < 0) {
            calcOffset += filterOffset * bitmapWidthX4;
          }
          if (filterY + offsetY >= bitmapHeight) {
            calcOffset -= filterOffset * bitmapWidthX4;
          }
          if (filterX + offsetX < 0) {
            calcOffset += filterOffset * 4;
          }
          if (filterX + offsetX >= bitmapWidth) {
            calcOffset -= filterOffset * 4;
          }
          for (let i = 0; i < 4; i++) {
            neighborPixels[i].push(pixelBuffer[calcOffset + i]);
          }
        }
      }
      let median = Math.floor((matrixSize * matrixSize) / 2);
      for (let i = 0; i < 4; i++) {
        neighborPixels[i].sort((a, b) => a - b);
        resultBuffer[byteOffset + i] = neighborPixels[i][median];
        neighborPixels[i] = [];
      }
    }
  }
  return resultBuffer;
}

function convolutionFilter({
  sourceBitmap,
  filterMatrix,
  factor = 1,
  bias = 0,
  height,
  width,
}) {
  const pixelBuffer = [...sourceBitmap];
  const resultBuffer = new Array(sourceBitmap.length);
  const filterWidth = filterMatrix[0].length;
  const filterOffset = Math.floor((filterWidth - 1) / 2);
  const bitmapHeight = height;
  const bitmapWidth = width;
  const bitmapWidthX4 = bitmapWidth * 4;

  for (let offsetY = 0; offsetY < bitmapHeight; offsetY++) {
    for (let offsetX = 0; offsetX < bitmapWidth; offsetX++) {
      let blue = 0;
      let green = 0;
      let red = 0;
      const byteOffset = offsetY * bitmapWidthX4 + offsetX * 4;
      for (let filterY = -filterOffset; filterY <= filterOffset; filterY++) {
        for (let filterX = -filterOffset; filterX <= filterOffset; filterX++) {
          let calcOffset = byteOffset + filterX * 4 + filterY * bitmapWidthX4;
          if (filterY + offsetY < 0) {
            calcOffset += filterOffset * bitmapWidthX4;
          }
          if (filterY + offsetY >= bitmapHeight) {
            calcOffset -= filterOffset * bitmapWidthX4;
          }
          if (filterX + offsetX < 0) {
            calcOffset += filterOffset * 4;
          }
          if (filterX + offsetX >= bitmapWidth) {
            calcOffset -= filterOffset * 4;
          }
          blue +=
            pixelBuffer[calcOffset] *
            filterMatrix[filterY + filterOffset][filterX + filterOffset];
          green +=
            pixelBuffer[calcOffset + 1] *
            filterMatrix[filterY + filterOffset][filterX + filterOffset];
          red +=
            pixelBuffer[calcOffset + 2] *
            filterMatrix[filterY + filterOffset][filterX + filterOffset];
        }
      }

      const [R, G, B] = normalizeRgb(red, green, blue, factor, bias);
      resultBuffer[byteOffset] = B;
      resultBuffer[byteOffset + 1] = G;
      resultBuffer[byteOffset + 2] = R;
      resultBuffer[byteOffset + 3] = 255;
    }
  }
  return resultBuffer;
}

function ConvolutionFilterForSobel({
  sourceBitmap,
  xFilterMatrix,
  yFilterMatrix,
  grayscale = true,
  width,
  height,
}) {
  const pixelBuffer = [...sourceBitmap];
  const resultBuffer = new Array(sourceBitmap.length);
  if (grayscale) {
    for (let k = 0; k < pixelBuffer.length; k += 4) {
      let rgb = pixelBuffer[k] * 0.11;
      rgb += pixelBuffer[k + 1] * 0.59;
      rgb += pixelBuffer[k + 2] * 0.3;
      pixelBuffer[k] = rgb & 255;
      pixelBuffer[k + 1] = pixelBuffer[k];
      pixelBuffer[k + 2] = pixelBuffer[k];
      pixelBuffer[k + 3] = 255;
    }
  }
  const filterWidth = xFilterMatrix[0].length;
  const filterOffset = Math.floor((filterWidth - 1) / 2);
  const bitmapHeight = height;
  const bitmapWidth = width;
  const bitmapWidthX4 = bitmapWidth * 4;

  for (let offsetY = 0; offsetY < bitmapHeight; offsetY++) {
    for (let offsetX = 0; offsetX < bitmapWidth; offsetX++) {
      let blueX = 0,
        greenX = 0,
        redX = 0;
      let blueY = 0,
        greenY = 0,
        redY = 0;
      const byteOffset = offsetY * bitmapWidthX4 + offsetX * 4;
      for (let filterY = -filterOffset; filterY <= filterOffset; filterY++) {
        for (let filterX = -filterOffset; filterX <= filterOffset; filterX++) {
          let calcOffset = byteOffset + filterX * 4 + filterY * bitmapWidthX4;
          if (filterY + offsetY < 0) {
            calcOffset += filterOffset * bitmapWidthX4;
          }
          if (filterY + offsetY >= bitmapHeight) {
            calcOffset -= filterOffset * bitmapWidthX4;
          }
          if (filterX + offsetX < 0) {
            calcOffset += filterOffset * 4;
          }
          if (filterX + offsetX >= bitmapWidth) {
            calcOffset -= filterOffset * 4;
          }
          blueX +=
            pixelBuffer[calcOffset] *
            xFilterMatrix[filterY + filterOffset][filterX + filterOffset];
          greenX +=
            pixelBuffer[calcOffset + 1] *
            xFilterMatrix[filterY + filterOffset][filterX + filterOffset];
          redX +=
            pixelBuffer[calcOffset + 2] *
            xFilterMatrix[filterY + filterOffset][filterX + filterOffset];
          blueY +=
            pixelBuffer[calcOffset] *
            yFilterMatrix[filterY + filterOffset][filterX + filterOffset];
          greenY +=
            pixelBuffer[calcOffset + 1] *
            yFilterMatrix[filterY + filterOffset][filterX + filterOffset];
          redY +=
            pixelBuffer[calcOffset + 2] *
            yFilterMatrix[filterY + filterOffset][filterX + filterOffset];
        }
      }
      let blueTotal = Math.sqrt(blueX * blueX + blueY * blueY);
      let greenTotal = Math.sqrt(greenX * greenX + greenY * greenY);
      let redTotal = Math.sqrt(redX * redX + redY * redY);
      if (blueTotal > 255) {
        blueTotal = 255;
      } else if (blueTotal < 0) {
        blueTotal = 0;
      }
      if (greenTotal > 255) {
        greenTotal = 255;
      } else if (greenTotal < 0) {
        greenTotal = 0;
      }
      if (redTotal > 255) {
        redTotal = 255;
      } else if (redTotal < 0) {
        redTotal = 0;
      }
      resultBuffer[byteOffset] = 255 & blueTotal;
      resultBuffer[byteOffset + 1] = 255 & greenTotal;
      resultBuffer[byteOffset + 2] = 255 & redTotal;
      resultBuffer[byteOffset + 3] = 255;
    }
  }
  return resultBuffer;
}

function normalizeRgb(red, green, blue, factor, bias) {
  red = factor * red + bias;
  green = factor * green + bias;
  blue = factor * blue + bias;

  if (red > 255) {
    red = 255;
  } else if (red < 0) {
    red = 0;
  }

  if (green > 255) {
    green = 255;
  } else if (green < 0) {
    green = 0;
  }

  if (blue > 255) {
    blue = 255;
  } else if (blue < 0) {
    blue = 0;
  }

  return [red, green, blue];
}
