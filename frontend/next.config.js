/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: [
      'image.tmdb.org', // TMDB images
      'img.omdbapi.com', // OMDB images
    ],
  },
  // Enable styled-components
  compiler: {
    styledComponents: true,
  },
  // Disable TypeScript
  typescript: {
    ignoreBuildErrors: true,
  },
}

module.exports = nextConfig 