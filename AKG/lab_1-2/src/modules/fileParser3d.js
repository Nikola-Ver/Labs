import { triangulate } from './triangulate';

export function get3dModel(file) {
  // eslint-disable-next-line no-regex-spaces
  const parsedFile = file.replace(/  +/g, ' ');
  const vArray = parsedFile.match(/^v .*$/gm);
  const vtArray = parsedFile.match(/^vt .*$/gm);
  const vnArray = parsedFile.match(/^vn .*$/gm);
  const fArray = parsedFile.match(/^f .*$/gm);

  return {
    v: vArray?.map((e) =>
      [...e.trim().split(' ').slice(1), 1].map((el) => Number(el)),
    ),
    vt: vtArray?.map((e) =>
      e
        .trim()
        .split(' ')
        .slice(1)
        .map((el) => Number(el)),
    ),
    vn: vnArray?.map((e) =>
      e
        .trim()
        .split(' ')
        .slice(1)
        .map((el) => Number(el)),
    ),
    f: triangulate(
      fArray?.map((e) =>
        e
          .trim()
          .split(' ')
          .slice(1)
          .map((el) => {
            const values = el.split('/').map((elem) => Number(elem));
            return {
              v: values[0],
              vt: values[1],
              vn: values[2],
            };
          }),
      ),
    ),
  };
}
