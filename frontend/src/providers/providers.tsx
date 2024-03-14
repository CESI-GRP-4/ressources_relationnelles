// providers.tsx
// Generic Providers Component
import React from 'react';
import AntdConfigProvider from '@/providers/antd/antdConfigProvider';
import AntdRegistry from '@/providers/antd/antdRegistry';
import UserProvider from '@/providers/userProvider';
import { ConsentProvider } from '@/contexts/CookiesConsentContext';

const Providers: React.FC<React.PropsWithChildren<{}>> = ({ children }) => {
       return (
              <ConsentProvider>
                     <UserProvider>
                            <AntdConfigProvider>
                                   <AntdRegistry>
                                          {children}
                                   </AntdRegistry>
                            </AntdConfigProvider>
                     </UserProvider>
              </ConsentProvider >
       );
};

export default Providers;
