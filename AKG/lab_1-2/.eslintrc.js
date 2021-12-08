module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: ['plugin:react/recommended', 'airbnb', 'prettier'],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: ['react'],
  rules: {
    'no-plusplus': 'off',
    'no-bitwise': 'off',
    curly: ['error', 'all'],
    'import/prefer-default-export': 'off',
    'react/react-in-jsx-scope': 'off',
    'implicit-arrow-linebreak': 'off',
    'no-unused-vars': 'off',
  },
};
