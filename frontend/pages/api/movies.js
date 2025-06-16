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
 * @param {NextApiRequest} req - The incoming request
 * @param {NextApiResponse} res - The response object
 */
export default async function handler(req, res) {
  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' })
  }

  try {
    // Get session for authentication
    const session = await getServerSession(req, res, authOptions)
    if (!session) {
      return res.status(401).json({ error: 'Unauthorized' })
    }

    // Parse and validate search parameters
    const { query, page = '1', limit = '20' } = req.query
    const validatedParams = searchSchema.parse({
      query,
      page: parseInt(page),
      limit: parseInt(limit),
    })

    // Generate cache key
    const cacheKey = `${CACHE_KEY_PREFIX}${validatedParams.query}:${validatedParams.page}`

    // Check cache (implement your caching solution here)
    // const cachedData = await cache.get(cacheKey)
    // if (cachedData) {
    //   return res.json(cachedData)
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

    // Set cache headers
    res.setHeader('Cache-Control', `public, s-maxage=${CACHE_TTL}, stale-while-revalidate=${CACHE_TTL * 2}`)
    return res.json(data)
  } catch (error) {
    console.error('Movie search error:', error)

    if (error instanceof z.ZodError) {
      return res.status(400).json({
        error: 'Invalid search parameters',
        details: error.errors,
      })
    }

    return res.status(500).json({ error: 'Internal server error' })
  }
}

// Configure API route
export const config = {
  api: {
    bodyParser: false, // Disable body parsing since we only use query params
  },
} 