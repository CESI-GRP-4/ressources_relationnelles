// layout.tsx (about page layout)
import React from 'react';

export default function RootLayout({
       children,
}: {
       children: React.ReactNode;
}) {
       return (
              <div>
                     <div>Layout of the about page</div>
                     <div>{children}</div>
              </div>
       );
}
