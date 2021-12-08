const P = 0.4;
const PI1 = 0.6;
const PI2 = 0.6;

const obj = {
  j: 0,
  t1: false,
  t2: false,
};

const taskAmount = 100000;

let currentTaskAmount = taskAmount;
while (true) {
  const PSuccess = Math.random() - P > 0;
  const PI1Success = Math.random() - PI1 > 0;
  const PI2Success = Math.random() - PI2 > 0;

  if (obj.t2) {
    if (PI2Success) {
      obj.t2 = false;
    }
  }

  if (obj.t1) {
    if (PI1Success) {
      if (!obj.t2) {
        obj.t2 = true;
      }
      obj.t1 = false;
    }
  }

  if (obj.j) {
      if (!obj.t1) {
          obj.t1 = true;
          --obj.j;
      }
  }

  if (PSuccess) {
      if (!obj.j) {
          ++obj.j;
      }
  }

  if (!currentTaskAmount && !obj.j && !obj.t1 && !obj.t2) break;
}
