// antdConfigProvider.tsx
// see documentation : https://ant.design/docs/react/i18n#configprovider
// "use client" directive is required here, otherwise it will return an unhandled error

"use client"
import React from 'react';
import { ConfigProvider } from 'antd';
import frFR from 'antd/locale/fr_FR';

// Ant Design Provider
const AntdConfigProvider: React.FC<React.PropsWithChildren<{}>> = ({ children }) => {
       return (
              <ConfigProvider locale={frFR}>
                     {children}
              </ConfigProvider>
       );
};

export default AntdConfigProvider;