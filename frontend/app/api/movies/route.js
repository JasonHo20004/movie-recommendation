import { NextResponse } from 'next/server'
import { z } from 'zod'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// Input validation schema
const searchSchema = z.object({
  query: z.string().min(1).max(100),
  page: z.number().int().min(1).default(1),
  limit: z.number().int().min(1).max(50).default(20),
})

// Cache configuration
const CACHE_TTL = 60 * 60 // 1 hour in seconds
const CACHE_KEY_PREFIX = 'movies:'

/**
 * GET handler for movie search
 * @param {Request} request - The incoming request
 */
export async function GET(request) {
  try {
    // Get session for authentication
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    // Parse and validate search parameters
    const { searchParams } = new URL(request.url)
    const query = searchParams.get('query')
    const page = parseInt(searchParams.get('page') || '1')
    const limit = parseInt(searchParams.get('limit') || '20')

    const validatedParams = searchSchema.parse({ query, page, limit })

    // Generate cache key
    const cacheKey = `${CACHE_KEY_PREFIX}${validatedParams.query}:${validatedParams.page}`

    // Check cache (implement your caching solution here)
    // const cachedData = await cache.get(cacheKey)
    // if (cachedData) {
    //   return NextResponse.json(cachedData)
    // }

    // Fetch data from your backend
    const response = await fetch(
      `${process.env.BACKEND_URL}/api/movies/search?` + 
      new URLSearchParams({
        q: validatedParams.query,
        page: validatedParams.page.toString(),
        limit: validatedParams.limit.toString(),
      }),
      {
        headers: {
          'Authorization': `Bearer ${session.accessToken}`,
        },
      }
    )

    if (!response.ok) {
      throw new Error('Failed to fetch movies')
    }

    const data = await response.json()

    // Cache the results (implement your caching solution here)
    // await cache.set(cacheKey, data, CACHE_TTL)

    // Return the response with proper headers
    return NextResponse.json(data, {
      headers: {
        'Cache-Control': `public, s-maxage=${CACHE_TTL}, stale-while-revalidate=${CACHE_TTL * 2}`,
      },
    })
  } catch (error) {
    console.error('Movie search error:', error)

    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid search parameters', details: error.errors },
        { status: 400 }
      )
    }

    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

// Configure route segment config
export const runtime = 'edge' // Use edge runtime for better performance
export const dynamic = 'force-dynamic' // Disable static optimization
export const revalidate = 3600 // Revalidate every hour 