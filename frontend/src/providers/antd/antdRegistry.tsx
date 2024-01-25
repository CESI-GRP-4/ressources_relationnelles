// antRegistry.tsx
// Ant Design documentation suggests to use its "Registry" to avoid page flickering : https://ant.design/docs/react/use-with-next#using-app-router

import React from 'react';
import { AntdRegistry as Registry } from '@ant-design/nextjs-registry';

const AntdRegistry: React.FC<React.PropsWithChildren<{}>> = ({ children }) => {
       return (
              <Registry>
                     {children}
              </Registry>
       );
};

export default AntdRegistry;