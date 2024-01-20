// providers.tsx
// Generic Providers Component
import React from 'react';
import AntdConfigProvider from '@/providers/antd/antdConfigProvider';
import AntdRegistry from '@/providers/antd/antdRegistry';
import UserProvider from '@/providers/userProvider';

const Providers: React.FC<React.PropsWithChildren<{}>> = ({ children }) => {
       return (
              <UserProvider>
                     <AntdConfigProvider>
                            <AntdRegistry>
                                   {children}
                            </AntdRegistry>
                     </AntdConfigProvider>
              </UserProvider>
       );
};

export default Providers;
