import { Tabs } from 'antd';
import type { TabsProps } from 'antd';
import { Icon } from '@iconify/react';
import Ressource from '@/types/ressource';

export default function RessourceData({props, ressource} : { props? : TabsProps, ressource: Ressource}) {
       const items: TabsProps["items"] = [
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon icon={"fluent:content-view-16-regular"} /> <span>{`Contenu de la ressource`}</span></div> ,
                     key: 'content',
                     children: <div><pre>{ressource.description}</pre></div>
              },
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon icon={"oui:documents"} /> <span>{`Documents`}</span></div>,
                     key: 'documents',
              },
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon icon={"tabler:messages"} /> <span>{`Discussion`}</span></div>,
                     key: 'discussion',
              },
       ];

       return (
              <Tabs defaultActiveKey="content" items={items} {...props} />
       );
}