import { useState } from "react";
import axios from "axios";
import { Button, Tooltip, message } from 'antd';
import { LogoutOutlined } from '@ant-design/icons';
import { useUser } from "@/providers/userProvider";

export default function LogoutButton() {
       const { setUser } = useUser();
       const [isLogoutLoading, setLogoutLoading] = useState(false);

       const handleLogout = async (): Promise<void> => {
              setLogoutLoading(true);
              try {
                     const logOutResponse = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api',
                            url: "/logout",
                            withCredentials: true, // Necessary for HTTP-only cookies in cross-origin scenarios
                            responseType: 'json',
                            timeout: 10000, // Increased value because we had some timeout errors
                     });

                     if (logOutResponse.status === 200){
                            message.success('Déconnexion réussie');
                            setUser(null);
                     }
                     // * Don't need to check for the status code here, because the request will throw an error if it fails
                     
              } catch (error) {
                     console.error('Logout request failed:', error);
                     // TODO : Handle error with switch case on error.response.status
              }
              finally{
                     setLogoutLoading(false);
              }
       };

       return (
              <Tooltip title="Logout">
                     <Button loading={isLogoutLoading} danger size="large" onClick={handleLogout} shape="circle" icon={<LogoutOutlined />} />
              </Tooltip>
       );
}
