/** @type {import('next').NextConfig} */
const nextConfig = {
       images: {
              remotePatterns: [
                     {
                            protocol: 'https',
                            hostname: 'upload.wikimedia.org',
                            port: '',
                     },
                     {
                            protocol: 'https',
                            hostname: 'licdn.com',
                            port: '',
                     },
                     {
                            protocol: 'https',
                            hostname: 'media.licdn.com',
                            port: '',
                     },
                     {
                            protocol: 'https',
                            hostname: 'github.com',
                            port: '',
                     }
              ],
       },

       reactStrictMode: true, // Enable React strict mode for improved error handling
       swcMinify: true,      // Enable SWC minification for improved performance
       compiler: {
              removeConsole: process.env.NODE_ENV !== "development", // Remove console.log in production
       },
}

// Configuration object tells the next-pwa plugin 
const withPWA = require("next-pwa")({
       dest: "public", // Destination directory for the PWA files
       // disable: process.env.NODE_ENV === "development", // Disable PWA in development mode
       register: true, // Register the PWA service worker
       skipWaiting: true, // Skip waiting for service worker activation
});

// Export the combined configuration for Next.js with PWA support
module.exports = withPWA(nextConfig);