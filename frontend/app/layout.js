import "./globals.css";
import Head from "./head";
import Header from "../components/shared/header/header";
import 'bootstrap/dist/css/bootstrap.css';

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <Head />
      <body>
          <Header className='headerBar'/>
          {children}
      </body>
    </html>
  );
} 