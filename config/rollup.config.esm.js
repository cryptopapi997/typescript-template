import typescript from '@rollup/plugin-typescript';

const config = [{
    output: {
        file: 'build/index.mjs',
        format: 'esm',
        sourcemap: false,
        inlineDynamicImports: true,
    },
    plugins: [
        typescript(),
    ],
}];
export default config;
