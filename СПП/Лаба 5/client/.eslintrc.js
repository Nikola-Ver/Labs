module.exports = {
  env: {
    browser: true,
    es6: true,
  },
  extends: ["plugin:react/recommended", "airbnb", "prettier"],
  globals: {
    Atomics: "readonly",
    SharedArrayBuffer: "readonly",
  },
  parser: "babel-eslint",
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 2020,
    sourceType: "module",
  },
  plugins: ["react", "react-hooks"],
  root: true,
  rules: {
    "arrow-body-style": "off",
    "import/prefer-default-export": "off",
    "react/react-in-jsx-scope": "off",
    "react/self-closing-comp": "off",
    "react/jsx-filename-extension": "off",
    "react/prop-types": "off",
    "no-underscore-dangle": "off",
    "no-unused-vars": [
      "warn",
      {
        argsIgnorePattern:
          "^(e|err|event|props|theme|res|dispatch|getState|_.*)$",
      },
    ],
  },
};
