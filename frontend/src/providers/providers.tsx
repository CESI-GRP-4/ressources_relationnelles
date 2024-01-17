// providers.tsx
// Generic Providers Component
import React from 'react';
import AntdConfigProvider from '@/providers/antd/antdConfigProvider';
import AntdRegistry from '@/providers/antd/antdRegistry';

const Providers: React.FC<React.PropsWithChildren<{}>> = ({ children }) => {
       return (
              <AntdConfigProvider>
                     <AntdRegistry>
                            {children}
                     </AntdRegistry>
              </AntdConfigProvider>
       );
};

export default Providers;
