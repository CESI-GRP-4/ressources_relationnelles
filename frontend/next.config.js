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
}

module.exports = nextConfig
