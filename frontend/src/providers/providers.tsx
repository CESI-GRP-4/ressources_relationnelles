// providers.tsx
// Generic Providers Component
import React from 'react';
import AntdConfigProvider from '@/providers/antd/antdConfigProvider';
import AntdRegistry from '@/providers/antd/antdRegistry';
import UserProvider from '@/providers/userProvider';
import { ConsentProvider } from '@/contexts/CookiesConsentContext';
import { WCAGProvider } from '@/contexts/wcagContext';

const Providers: React.FC<React.PropsWithChildren<{}>> = ({ children }) => {
       return (
              <ConsentProvider>
                     <WCAGProvider>
                            <UserProvider>
                                   <AntdConfigProvider>
                                          <AntdRegistry>
                                                 {children}
                                          </AntdRegistry>
                                   </AntdConfigProvider>
                            </UserProvider>
                     </WCAGProvider>
              </ConsentProvider >
       );
};

export default Providers;
