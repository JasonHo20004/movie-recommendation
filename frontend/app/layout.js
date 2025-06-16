import { Inter, Libre_Baskerville } from 'next/font/google'
import { Providers } from '@/providers'
import '@/styles/globals.css'

// Use Google Fonts instead of local font
const inter = Inter({
  subsets: ['latin'],
  variable: '--font-inter',
  display: 'swap',
  preload: true,
})

const libreBaskerville = Libre_Baskerville({
  weight: ['400', '700'],
  style: ['normal', 'italic'],
  subsets: ['latin'],
  variable: '--font-libre-baskerville',
  display: 'swap',
  preload: true,
})

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
      <body className={`${inter.variable} ${libreBaskerville.variable} font-sans`}>
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  )
} 