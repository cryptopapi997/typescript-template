import typescript from '@rollup/plugin-typescript';

const config = [{
    output: {
        file: 'build/index.cjs',
        format: 'cjs',
        sourcemap: false,
        inlineDynamicImports: true,
    },
    plugins: [
        typescript(),
    ],
}];
export default config;
