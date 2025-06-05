export async function GET() {
  return new Response(JSON.stringify({ message: "Send a POST request to echo data!" }), {
    headers: { 'Content-Type': 'application/json' },
  });
}

export async function POST(request) {
  const data = await request.json();
  return new Response(JSON.stringify({ youSent: data }), {
    headers: { 'Content-Type': 'application/json' },
  });
} 