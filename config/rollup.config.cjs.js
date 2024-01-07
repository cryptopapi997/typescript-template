import typescript from '@rollup/plugin-typescript';

const config = [{
    output: {
        file: 'build/index.cjs',
        format: 'cjs',
        sourcemap: false,
        inlineDynamicImports: true,
    },
    input: 'src/index.ts',
    plugins: [
        typescript(),
    ],
}];
export default config;
