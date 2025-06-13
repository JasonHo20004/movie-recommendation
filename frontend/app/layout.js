import { Inter } from 'next/font/google'
import { Providers } from '@/providers'
import '@/styles/globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'),
  title: {
    default: 'Movie Recommendation System',
    template: '%s | Movie Recommendations'
  },
  description: 'Discover your next favorite movie with our AI-powered recommendation system',
  keywords: ['movies', 'recommendations', 'AI', 'entertainment'],
  authors: [{ name: 'Your Name' }],
  openGraph: {
    type: 'website',
    locale: 'en_US',
    url: '/',
    title: 'Movie Recommendation System',
    description: 'Discover your next favorite movie with our AI-powered recommendation system',
    siteName: 'Movie Recommendations'
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Movie Recommendation System',
    description: 'Discover your next favorite movie with our AI-powered recommendation system',
    creator: '@yourusername'
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  verification: {
    google: 'your-google-site-verification',
  }
}

export const viewport = {
  themeColor: [
    { media: '(prefers-color-scheme: light)', color: 'white' },
    { media: '(prefers-color-scheme: dark)', color: 'black' }
  ],
  width: 'device-width',
  initialScale: 1,
  maximumScale: 1,
}

export default function RootLayout({ children }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={inter.className}>
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  )
} 