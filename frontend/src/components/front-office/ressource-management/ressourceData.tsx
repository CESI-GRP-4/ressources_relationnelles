import { Tabs, Tooltip } from 'antd';
import type { TabsProps } from 'antd';
import { Icon } from '@iconify/react';
import Ressource from '@/types/ressource';
import Comments from './comments';
import { CommentProvider } from '@/contexts/CommentContext';

export default function RessourceData({ props, ressource }: { props?: TabsProps, ressource: Ressource }) {
       const items: TabsProps["items"] = [
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon style={{ fontSize: "2rem" }} icon={"fluent:content-view-16-regular"} /> <span>{`Contenu de la ressource`}</span></div>,
                     key: 'content',
                     children: <div className='overflow-x-auto'>
                            <pre className='whitespace-pre-wrap'>{ressource.description}</pre>
                     </div>

              },
              {
                     label: <Tooltip title="Fonctionnalité bientôt disponible"><div className="flex flex-row items-center space-x-2"><Icon style={{ fontSize: "1.8rem" }} icon={"oui:documents"} /> <span>{`Documents`}</span></div></Tooltip>,
                     key: 'documents',
                     disabled: true
              },
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon style={{ fontSize: "2rem" }} icon={"typcn:messages"} /> <span>{`Discussion`}</span></div>,
                     key: 'discussion',
                     children: <CommentProvider><Comments disableComment={ressource.status !== "accepted"} comments={ressource.comments} idRessource={ressource.id} /> </CommentProvider>
              },
       ];

       return (
              <Tabs className='w-full' defaultActiveKey="content" items={items} {...props} />
       );
}