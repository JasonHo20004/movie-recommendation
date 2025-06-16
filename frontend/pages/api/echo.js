import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export default async function handler(req, res) {
  // Only allow GET and POST methods
  if (req.method !== 'GET' && req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' })
  }

  try {
    // Get session for authentication
    const session = await getServerSession(req, res, authOptions)
    if (!session) {
      return res.status(401).json({ error: 'Unauthorized' })
    }

    if (req.method === 'GET') {
      return res.status(200).json({ message: "Send a POST request to echo data!" })
    }

    if (req.method === 'POST') {
      const data = req.body
      return res.status(200).json({ youSent: data })
    }
  } catch (error) {
    console.error('Echo API error:', error)
    return res.status(500).json({ error: 'Internal server error' })
  }
}

// Configure API route
export const config = {
  api: {
    bodyParser: true, // Enable body parsing for POST requests
  },
} 