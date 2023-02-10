import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    server: {
        host: '10.1.15.11',
    },
    plugins: [
        laravel({
            input: [
                'resources/css/app.css',
                'resources/js/app.js',
            ],
            refresh: true,

        }),
    ],


    /* plugins: [
        laravel([
            'resources/css/app.css',
            'resources/js/app.js',
        ]),
    ],*/
});
