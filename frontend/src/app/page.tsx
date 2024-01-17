// page.tsx (default page at frontend/src/app/page.tsx)

import { Button } from 'antd'

export default function Home() {
       return (
              <main className="flex max-h-screen flex-col items-center p-24 space-y-10">
                     <span className="text-red-500">If this text is not Red, check your project and Tailwindcss configuration. Bellow is a Ant Design button, if it is not displayed correctly, check your project and antd configuration :</span>
                     <Button type="primary">Button</Button>
              </main>
       )
}